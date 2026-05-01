import SwiftUI
import AppKit

@main
struct eBeyannameApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    NSApplication.shared.activate(ignoringOtherApps: true)
                    removeUnwantedMenus()
                }
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem) { }
            CleanMenuCommands()
        }

        Settings {
            SettingsView(updater: appState.updaterController.updater)
                .environmentObject(appState)
        }
    }
}

// Replaces all SwiftUI-controlled menu groups with empty content.
// Edit, View, Window and Help are then removed via NSApp.mainMenu in onAppear.
struct CleanMenuCommands: Commands {
    var body: some Commands {
        CommandGroup(replacing: .textEditing) { }
        CommandGroup(replacing: .pasteboard) { }
        CommandGroup(replacing: .undoRedo) { }
        CommandGroup(replacing: .toolbar) { }
        CommandGroup(replacing: .sidebar) { }
        CommandGroup(replacing: .help) { }
    }
}

private func removeUnwantedMenus() {
    guard let menuBar = NSApplication.shared.mainMenu else { return }
    ["Edit", "View", "Window", "Help", "File"].forEach { title in
        if let item = menuBar.item(withTitle: title) {
            menuBar.removeItem(item)
        }
    }
    // Rename the SwiftUI-generated "Settings..." to Turkish
    if let appMenu = menuBar.item(at: 0)?.submenu {
        appMenu.items.forEach { item in
            if item.title == "Settings..." {
                item.title = "Ayarlar..."
            }
        }
    }
}
