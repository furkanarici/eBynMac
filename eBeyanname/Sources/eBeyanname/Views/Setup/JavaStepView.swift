import SwiftUI

struct JavaStepView: View {
    @EnvironmentObject var appState: AppState
    @State private var hasChecked = false

    var body: some View {
        StepContainerView(
            title: "Java Kurulumu",
            subtitle: "eBeyanname çalışmak için Java gerektirir.",
            systemImage: "cup.and.saucer.fill"
        ) {
            switch appState.javaStatus {
            case .unchecked, .checking:
                VStack(spacing: 20) {
                    if appState.javaStatus == .checking {
                        ProgressView("Java kontrol ediliyor...")
                    } else {
                        Button("Java Sürümünü Kontrol Et") {
                            checkJava()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                }

            case .installed:
                StatusBanner(
                    icon: "checkmark.circle.fill",
                    color: .green,
                    title: "Java Kurulu",
                    message: "Java \(JavaService.shared.version ?? 0) tespit edildi. Devam edebilirsiniz."
                )
                nextButton

            case .notInstalled, .failed:
                VStack(spacing: 16) {
                    StatusBanner(
                        icon: "xmark.circle.fill",
                        color: .red,
                        title: "Java Bulunamadı",
                        message: "Lütfen Java'yı indirip kurun, ardından tekrar kontrol edin."
                    )

                    Button("Java İndir") {
                        NSWorkspace.shared.open(URL(string: "https://www.java.com/en/download/")!)
                    }
                    .buttonStyle(.bordered)

                    Button("Tekrar Kontrol Et") { checkJava() }
                        .buttonStyle(.borderedProminent)
                }

            default:
                EmptyView()
            }
        }
        .onAppear {
            if !hasChecked { checkJava() }
        }
    }

    private var nextButton: some View {
        Button("Devam Et") {
            withAnimation { appState.currentSetupStep = .akia }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    private func checkJava() {
        hasChecked = true
        appState.javaStatus = .checking
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            await MainActor.run {
                appState.javaStatus = JavaService.shared.isInstalled ? .installed : .notInstalled
            }
        }
    }
}
