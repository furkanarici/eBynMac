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

        let delegate = DownloadProgressDelegate(progress: progress)
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
        defer { session.finishTasksAndInvalidate() }

        let (localURL, _) = try await session.download(from: url)

        try FileManager.default.moveItem(at: localURL, to: tempURL)
        return tempURL
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

private final class DownloadProgressDelegate: NSObject, URLSessionDownloadDelegate {
    let progress: @Sendable (Double) -> Void

    init(progress: @escaping @Sendable (Double) -> Void) {
        self.progress = progress
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite > 0 else { return }
        progress(Double(totalBytesWritten) / Double(totalBytesExpectedToWrite))
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {}
}
