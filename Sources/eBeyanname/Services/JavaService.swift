import Foundation

enum JavaServiceError: LocalizedError {
    case notInstalled
    case versionUndetectable

    var errorDescription: String? {
        switch self {
        case .notInstalled:         return "Java kurulu değil"
        case .versionUndetectable:  return "Java sürümü tespit edilemedi"
        }
    }
}

final class JavaService {
    static let shared = JavaService()
    private init() {}

    var isInstalled: Bool {
        executableURL != nil
    }

    var version: Int? {
        guard let output = runJavaVersion() else { return nil }
        return parseVersion(from: output)
    }

    /// JVM flags required for the detected Java version.
    var javaOpts: [String] {
        guard let ver = version, ver >= 9 else { return [] }
        return ["--add-opens", "java.desktop/java.beans=ALL-UNNAMED"]
    }

    var executableURL: URL? {
        // Check JAVA_HOME first, then PATH fallback
        if let javaHome = ProcessInfo.processInfo.environment["JAVA_HOME"] {
            let url = URL(fileURLWithPath: javaHome).appendingPathComponent("bin/java")
            if FileManager.default.isExecutableFile(atPath: url.path) { return url }
        }

        for path in ["/usr/bin/java", "/usr/local/bin/java"] {
            if FileManager.default.isExecutableFile(atPath: path) {
                return URL(fileURLWithPath: path)
            }
        }

        // Try /usr/libexec/java_home
        if let javaHome = resolveJavaHome() {
            let url = URL(fileURLWithPath: javaHome).appendingPathComponent("bin/java")
            if FileManager.default.isExecutableFile(atPath: url.path) { return url }
        }

        return nil
    }

    // MARK: - Private

    private func runJavaVersion() -> String? {
        guard let javaURL = executableURL else { return nil }

        let process = Process()
        let pipe = Pipe()
        process.executableURL = javaURL
        process.arguments = ["-version"]
        process.standardError = pipe

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            return nil
        }

        return String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)
    }

    private func parseVersion(from output: String) -> Int? {
        let pattern = #"version "([^"]+)""#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: output, range: NSRange(output.startIndex..., in: output)),
              let range = Range(match.range(at: 1), in: output) else { return nil }

        let versionString = String(output[range])
        let parts = versionString.split(separator: ".")
        guard let first = parts.first, let major = Int(first) else { return nil }

        // "1.8.x" format (Java 8 and older)
        if major == 1, parts.count > 1, let minor = Int(parts[1]) { return minor }
        return major
    }

    private func resolveJavaHome() -> String? {
        let process = Process()
        let pipe = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/libexec/java_home")
        process.standardOutput = pipe
        process.standardError = Pipe()

        do {
            try process.run()
            process.waitUntilExit()
        } catch {
            return nil
        }

        let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return output?.isEmpty == false ? output : nil
    }
}
