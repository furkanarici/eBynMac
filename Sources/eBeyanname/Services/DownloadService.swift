import Foundation

enum DownloadError: LocalizedError {
    case extractionFailed(Int32)
    case fileMoveError

    var errorDescription: String? {
        switch self {
        case .extractionFailed(let code): return "Dosya çıkarılamadı (kod: \(code))"
        case .fileMoveError:              return "İndirilen dosya taşınamadı"
        }
    }
}

final class DownloadService {
    static let shared = DownloadService()
    private init() {}

    /// Downloads a file from `url` and returns the local temp URL.
    func download(from url: URL, progress: @escaping @Sendable (Double) -> Void) async throws -> URL {
        let destName = url.lastPathComponent
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString + "-" + destName)

        return try await withCheckedThrowingContinuation { continuation in
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
            let task = session.downloadTask(with: url) { localURL, _, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let localURL else {
                    continuation.resume(throwing: DownloadError.fileMoveError)
                    return
                }
                do {
                    try FileManager.default.moveItem(at: localURL, to: tempURL)
                    continuation.resume(returning: tempURL)
                } catch {
                    continuation.resume(throwing: error)
                }
            }

            // KVO progress tracking
            let observation = task.progress.observe(\.fractionCompleted) { prog, _ in
                progress(prog.fractionCompleted)
            }

            task.resume()

            // Keep observation alive until task completes
            withExtendedLifetime(observation) {}
        }
    }

    /// Extracts a .tar.gz archive into the given directory.
    func extractTarGz(at archiveURL: URL, into directory: URL) throws {
        let fm = FileManager.default
        if !fm.fileExists(atPath: directory.path) {
            try fm.createDirectory(at: directory, withIntermediateDirectories: true)
        }

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/tar")
        process.arguments = ["-xzf", archiveURL.path, "-C", directory.path]
        try process.run()
        process.waitUntilExit()

        guard process.terminationStatus == 0 else {
            throw DownloadError.extractionFailed(process.terminationStatus)
        }
    }

    /// Extracts a .zip archive into the given directory.
    func extractZip(at archiveURL: URL, into directory: URL) throws {
        let fm = FileManager.default
        if !fm.fileExists(atPath: directory.path) {
            try fm.createDirectory(at: directory, withIntermediateDirectories: true)
        }

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
        process.arguments = ["-o", archiveURL.path, "-d", directory.path]
        try process.run()
        process.waitUntilExit()

        guard process.terminationStatus == 0 else {
            throw DownloadError.extractionFailed(process.terminationStatus)
        }
    }
}
