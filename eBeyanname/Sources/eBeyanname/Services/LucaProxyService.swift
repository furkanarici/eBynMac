import Foundation

enum LucaProxyError: LocalizedError {
    case scriptDownloadFailed
    case installationFailed(String)

    var errorDescription: String? {
        switch self {
        case .scriptDownloadFailed:       return "Luca Proxy kurulum scripti indirilemedi"
        case .installationFailed(let m):  return "Kurulum hatası: \(m)"
        }
    }
}

final class LucaProxyService {
    static let shared = LucaProxyService()

    private static let installScriptURL = URL(string: "https://auygs.luca.com.tr/Luca/yardim/uygulamalar/LucaProxyKurulumMac.sh")!
    private static let installDirectory = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("LucaProxy")
    private static let jarPath = installDirectory.appendingPathComponent("LucaProxy.jar")

    private init() {}

    var isInstalled: Bool {
        FileManager.default.fileExists(atPath: Self.jarPath.path)
    }

    func install(progress: @escaping @Sendable (Double) -> Void) async throws {
        // Download installation script
        let scriptURL = try await DownloadService.shared.download(
            from: Self.installScriptURL,
            progress: { p in progress(p * 0.3) } // first 30% for download
        )

        // Make executable and run
        let fm = FileManager.default
        var attributes = try fm.attributesOfItem(atPath: scriptURL.path)
        attributes[.posixPermissions] = 0o755
        try fm.setAttributes(attributes, ofItemAtPath: scriptURL.path)

        let process = Process()
        let pipe = Pipe()
        process.executableURL = URL(fileURLWithPath: "/bin/bash")
        process.arguments = [scriptURL.path]
        process.standardOutput = pipe
        process.standardError = pipe

        try process.run()

        // Simulate progress during install (indeterminate)
        Task {
            var p = 0.3
            while process.isRunning && p < 0.95 {
                try? await Task.sleep(nanoseconds: 200_000_000)
                p = min(p + 0.05, 0.95)
                progress(p)
            }
        }

        process.waitUntilExit()
        progress(1.0)

        guard process.terminationStatus == 0 else {
            let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
            throw LucaProxyError.installationFailed(output)
        }
    }

    func openDirectory() {
        NSWorkspace.shared.open(Self.installDirectory)
    }
}
