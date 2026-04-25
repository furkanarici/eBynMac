import SwiftUI
import Sparkle

@main
struct eBeyannameApp: App {
    @StateObject private var appState = AppState()
    private let updaterController: SPUStandardUpdaterController

    init() {
        updaterController = SPUStandardUpdaterController(
            startingUpdater: true,
            updaterDelegate: nil,
            userDriverDelegate: nil
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(after: .appInfo) {
                Button("Güncellemeleri Kontrol Et") {
                    updaterController.checkForUpdates(nil)
                }
            }
        }

        Settings {
            SettingsView(updater: updaterController.updater)
                .environmentObject(appState)
        }
    }
}
