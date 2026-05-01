import Foundation
import Combine
import Sparkle

@MainActor
final class AppState: ObservableObject {

    // MARK: - Updater

    let updaterController: SPUStandardUpdaterController


    // MARK: - Setup state

    @Published var isSetupComplete: Bool
    @Published var currentSetupStep: SetupStep = .welcome

    // MARK: - Component statuses

    @Published var javaStatus: ComponentStatus = .unchecked
    @Published var akiaStatus: ComponentStatus = .unchecked
    @Published var bdpStatus: ComponentStatus = .unchecked
    @Published var lucaProxyStatus: ComponentStatus = .unchecked

    // MARK: - Runtime state

    @Published var isBDPRunning = false
    @Published var bdpOutput: String = ""
    @Published var bdpUpdateAvailable = false

    private static let setupCompleteKey = "com.ebeyanname.setupComplete"

    init() {
        self.isSetupComplete = UserDefaults.standard.bool(forKey: Self.setupCompleteKey)
        #if DEBUG || DEVELOPMENT
        self.updaterController = SPUStandardUpdaterController(
            startingUpdater: false, updaterDelegate: nil, userDriverDelegate: nil)
        #else
        self.updaterController = SPUStandardUpdaterController(
            startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
        #endif
    }

    func markSetupComplete() {
        isSetupComplete = true
        UserDefaults.standard.set(true, forKey: Self.setupCompleteKey)
    }

    func resetSetup() {
        isSetupComplete = false
        UserDefaults.standard.set(false, forKey: Self.setupCompleteKey)
        currentSetupStep = .welcome
        javaStatus = .unchecked
        akiaStatus = .unchecked
        bdpStatus = .unchecked
        lucaProxyStatus = .unchecked
        bdpOutput = ""
    }

    func appendBDPOutput(_ text: String) {
        bdpOutput += text
        // Cap output to avoid memory growth
        if bdpOutput.count > 50_000 {
            bdpOutput = String(bdpOutput.suffix(40_000))
        }
    }
}
