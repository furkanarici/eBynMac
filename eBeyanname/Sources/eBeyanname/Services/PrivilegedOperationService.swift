import Foundation

enum PrivilegedOperationError: LocalizedError {
    case userCancelled
    case failed(String)

    var errorDescription: String? {
        switch self {
        case .userCancelled:      return "İşlem kullanıcı tarafından iptal edildi"
        case .failed(let msg):    return msg
        }
    }
}

/// Runs shell commands with administrator privileges via AppleScript.
final class PrivilegedOperationService {
    static let shared = PrivilegedOperationService()
    private init() {}

    func copyFile(from source: URL, to destination: URL) throws {
        let destDir = destination.deletingLastPathComponent().path.shellEscaped
        let src = source.path.shellEscaped
        let dst = destination.path.shellEscaped
        try run("mkdir -p \(destDir) && cp -f \(src) \(dst)")
    }

    func createDirectory(at url: URL) throws {
        let path = url.path.shellEscaped
        try run("mkdir -p \(path)")
    }

    func setOwner(of path: String, to user: String) throws {
        let escapedPath = path.shellEscaped
        try run("chown -R \(user) \(escapedPath)")
    }

    // MARK: - Private

    private func run(_ command: String) throws {
        // Escape double quotes inside the command for AppleScript
        let escaped = command.replacingOccurrences(of: "\\", with: "\\\\")
                             .replacingOccurrences(of: "\"", with: "\\\"")
        let script = "do shell script \"\(escaped)\" with administrator privileges"

        var error: NSDictionary?
        let appleScript = NSAppleScript(source: script)
        appleScript?.executeAndReturnError(&error)

        if let error {
            let message = error["NSAppleScriptErrorMessage"] as? String ?? "Bilinmeyen hata"
            if message.lowercased().contains("cancel") {
                throw PrivilegedOperationError.userCancelled
            }
            throw PrivilegedOperationError.failed(message)
        }
    }
}

private extension String {
    var shellEscaped: String {
        "'" + replacingOccurrences(of: "'", with: "'\\''") + "'"
    }
}
