import Foundation

enum BDPError: LocalizedError {
    case javaNotFound
    case alreadyRunning
    case launchFailed(String)

    var errorDescription: String? {
        switch self {
        case .javaNotFound:         return "Java bulunamadı. Lütfen önce Java kurun."
        case .alreadyRunning:       return "eBeyanname zaten çalışıyor"
        case .launchFailed(let m):  return "Başlatma hatası: \(m)"
        }
    }
}

final class BDPService {
    static let shared = BDPService()

    static let installDirectory = URL(fileURLWithPath: "/opt/ebyn")
    private static let downloadURL = URL(string: "https://ebeyanname.gib.gov.tr/ebyn_pardus.tar.gz")!
    private static let classpath = "beydef.jar:bdp.jar:csfc.jar:debugger.jar:cs_mdi.jar:lf.jar:JavaRenderer.jar:ice-5_06_3.jar"
    private static let mainClass = "bdp_mf"

    private var runningProcess: Process?

    private init() {}

    var isInstalled: Bool {
        let jar = Self.installDirectory.appendingPathComponent("bdp.jar")
        return FileManager.default.fileExists(atPath: jar.path)
    }

    var isRunning: Bool {
        runningProcess?.isRunning == true
    }

    // MARK: - Download / Update

    func download(progress: @escaping @Sendable (Double) -> Void) async throws {
        let archiveURL = try await DownloadService.shared.download(from: Self.downloadURL, progress: progress)

        let extractDir = Self.installDirectory.appendingPathComponent("download/ebyn_pardus")
        try DownloadService.shared.extractTarGz(at: archiveURL, into: extractDir)

        // Copy extracted files to /opt/ebyn
        let fm = FileManager.default
        let contents = try fm.contentsOfDirectory(at: extractDir, includingPropertiesForKeys: nil)
        for item in contents {
            let dest = Self.installDirectory.appendingPathComponent(item.lastPathComponent)
            if fm.fileExists(atPath: dest.path) { try fm.removeItem(at: dest) }
            try fm.copyItem(at: item, to: dest)
        }

        // Clean up download directory
        try? fm.removeItem(at: extractDir.deletingLastPathComponent())
        try? fm.createDirectory(at: Self.installDirectory.appendingPathComponent("download"),
                                withIntermediateDirectories: true)
    }

    // MARK: - Launch

    func launch(outputHandler: @escaping @Sendable (String) -> Void) throws {
        guard !isRunning else { throw BDPError.alreadyRunning }

        let javaService = JavaService.shared
        guard let javaURL = javaService.executableURL else { throw BDPError.javaNotFound }

        let process = Process()
        let outputPipe = Pipe()

        process.executableURL = javaURL
        process.currentDirectoryURL = Self.installDirectory
        process.arguments = javaService.javaOpts + [
            "-Xmx256m",
            "-Dcom.cs.uid.renderer.java.runtime.UIBeanClassCache.packageName=",
            "-Dcom.cs.uid.renderer.java.runtime.UIBeanClassCache.checkForModification=false",
            "-classpath", Self.classpath,
            Self.mainClass
        ]
        process.standardOutput = outputPipe
        process.standardError = outputPipe

        outputPipe.fileHandleForReading.readabilityHandler = { handle in
            let data = handle.availableData
            guard !data.isEmpty,
                  let text = String(data: data, encoding: .utf8) else { return }
            outputHandler(text)
        }

        process.terminationHandler = { [weak self] _ in
            self?.runningProcess = nil
            outputPipe.fileHandleForReading.readabilityHandler = nil
        }

        do {
            try process.run()
            runningProcess = process
        } catch {
            throw BDPError.launchFailed(error.localizedDescription)
        }
    }

    func terminate() {
        runningProcess?.terminate()
        runningProcess = nil
    }
}
