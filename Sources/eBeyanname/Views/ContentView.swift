import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            if appState.isSetupComplete {
                MainView()
            } else {
                SetupWizardView()
            }
        }
        .frame(minWidth: 620, minHeight: 480)
    }
}
