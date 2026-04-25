import Foundation

enum AkiaError: LocalizedError {
    case bundledLibraryNotFound
    case driverDownloadFailed

    var errorDescription: String? {
        switch self {
        case .bundledLibraryNotFound: return "Uygulama içinde libakisp11.dylib bulunamadı"
        case .driverDownloadFailed:   return "Akia sürücüsü indirilemedi"
        }
    }
}

final class AkiaService {
    static let shared = AkiaService()

    private static let libDestination = URL(fileURLWithPath: "/Library/Java/Extensions/libakisp11.dylib")
    private static let driverZipURL = URL(string: "https://kamusm.bilgem.tubitak.gov.tr/islemler/surucu_yukleme_servisi/suruculer/AkisKart/macos/Akia_macos_1_8_0.zip")!
    private static let driverExtractDir = URL(fileURLWithPath: "/opt/ebyn/download/akia")

    private init() {}

    /// True if the PKCS#11 library is in place.
    var isLibraryInstalled: Bool {
        FileManager.default.fileExists(atPath: Self.libDestination.path)
    }

    /// Copies the bundled libakisp11.dylib to /Library/Java/Extensions/ with admin privileges.
    func installLibrary() throws {
        guard let bundleURL = Bundle.module.url(forResource: "libakisp11", withExtension: "dylib") else {
            throw AkiaError.bundledLibraryNotFound
        }
        try PrivilegedOperationService.shared.copyFile(from: bundleURL, to: Self.libDestination)
    }

    /// Downloads the full Akia card reader driver zip, extracts it, opens the DMG.
    func installDriver(progress: @escaping @Sendable (Double) -> Void) async throws {
        let zipURL = try await DownloadService.shared.download(from: Self.driverZipURL, progress: progress)
        try DownloadService.shared.extractZip(at: zipURL, into: Self.driverExtractDir)

        // Find and open the .dmg so the user can complete the GUI installer
        let contents = try FileManager.default.contentsOfDirectory(
            at: Self.driverExtractDir,
            includingPropertiesForKeys: nil
        )
        if let dmg = contents.first(where: { $0.pathExtension == "dmg" }) {
            await MainActor.run {
                NSWorkspace.shared.open(dmg)
            }
        }
    }
}
