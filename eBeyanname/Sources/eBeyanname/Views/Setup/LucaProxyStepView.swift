import SwiftUI

struct LucaProxyStepView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        StepContainerView(
            title: "Luca Proxy",
            subtitle: "Luca muhasebe programı kullanıyorsanız proxy kurulumunu yapabilirsiniz. Bu adım isteğe bağlıdır.",
            systemImage: "network"
        ) {
            switch appState.lucaProxyStatus {
            case .unchecked:
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Button("Luca Proxy Kur") { installLucaProxy() }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)

                        Button("Bu Adımı Atla") { advance() }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                    }
                }

            case .checking:
                ProgressView("Kontrol ediliyor...")

            case .installed:
                VStack(spacing: 16) {
                    StatusBanner(
                        icon: "checkmark.circle.fill",
                        color: .green,
                        title: "Luca Proxy Kurulu",
                        message: "Luca Proxy başarıyla kuruldu."
                    )
                    nextButton
                }

            case .downloading(let p):
                VStack(spacing: 12) {
                    ProgressView("Luca Proxy kuruluyor...", value: p)
                    Text("%\(Int(p * 100))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

            case .installing:
                ProgressView("Kuruluyor...")

            case .notInstalled:
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Button("Luca Proxy Kur") { installLucaProxy() }
                            .buttonStyle(.borderedProminent)
                        Button("Atla") { advance() }
                            .buttonStyle(.bordered)
                    }
                }

            case .failed(let msg):
                VStack(spacing: 12) {
                    StatusBanner(icon: "xmark.circle.fill", color: .red, title: "Hata", message: msg)
                    HStack(spacing: 16) {
                        Button("Tekrar Dene") { installLucaProxy() }
                            .buttonStyle(.borderedProminent)
                        Button("Atla") { advance() }
                            .buttonStyle(.bordered)
                    }
                }
            }
        }
        .onAppear {
            appState.lucaProxyStatus = LucaProxyService.shared.isInstalled ? .installed : .notInstalled
        }
    }

    private var nextButton: some View {
        Button("Devam Et") { advance() }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
    }

    private func advance() {
        withAnimation { appState.currentSetupStep = .complete }
    }

    private func installLucaProxy() {
        Task {
            do {
                await MainActor.run { appState.lucaProxyStatus = .downloading(0) }
                try await LucaProxyService.shared.install { progress in
                    Task { @MainActor in appState.lucaProxyStatus = .downloading(progress) }
                }
                await MainActor.run { appState.lucaProxyStatus = .installed }
            } catch {
                await MainActor.run {
                    appState.lucaProxyStatus = .failed(error.localizedDescription)
                }
            }
        }
    }
}
