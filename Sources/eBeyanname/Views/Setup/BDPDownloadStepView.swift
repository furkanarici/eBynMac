import SwiftUI

struct BDPDownloadStepView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        StepContainerView(
            title: "eBeyanname Programı",
            subtitle: "GİB sunucusundan eBeyanname dosyaları indirilecek.",
            systemImage: "arrow.down.circle.fill"
        ) {
            switch appState.bdpStatus {
            case .unchecked:
                Button("eBeyanname'yi Kur") { downloadBDP() }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)

            case .checking:
                ProgressView("Kontrol ediliyor...")

            case .installed:
                StatusBanner(
                    icon: "checkmark.circle.fill",
                    color: .green,
                    title: "eBeyanname Kurulu",
                    message: "Program dosyaları /opt/ebyn konumunda mevcut."
                )
                nextButton

            case .downloading(let p):
                VStack(spacing: 12) {
                    ProgressView("eBeyanname indiriliyor...", value: p)
                    Text("%\(Int(p * 100))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

            case .installing:
                ProgressView("Dosyalar yerleştiriliyor...")

            case .notInstalled:
                VStack(spacing: 12) {
                    StatusBanner(
                        icon: "arrow.down.circle.fill",
                        color: .blue,
                        title: "İndirme Gerekli",
                        message: "eBeyanname dosyaları GİB sunucusundan indirilecek."
                    )
                    Button("İndir ve Kur") { downloadBDP() }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }

            case .failed(let msg):
                VStack(spacing: 12) {
                    StatusBanner(icon: "xmark.circle.fill", color: .red, title: "Hata", message: msg)
                    Button("Tekrar Dene") { downloadBDP() }
                        .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear { checkBDP() }
    }

    private var nextButton: some View {
        Button("Devam Et") {
            withAnimation { appState.currentSetupStep = .lucaProxy }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    private func checkBDP() {
        appState.bdpStatus = .checking
        Task {
            try? await Task.sleep(nanoseconds: 200_000_000)
            await MainActor.run {
                appState.bdpStatus = BDPService.shared.isInstalled ? .installed : .notInstalled
            }
        }
    }

    private func downloadBDP() {
        Task {
            do {
                await MainActor.run { appState.bdpStatus = .downloading(0) }
                try await BDPService.shared.download { progress in
                    Task { @MainActor in appState.bdpStatus = .downloading(progress) }
                }
                await MainActor.run { appState.bdpStatus = .installing }
                try? await Task.sleep(nanoseconds: 200_000_000)
                await MainActor.run { appState.bdpStatus = .installed }
            } catch {
                await MainActor.run {
                    appState.bdpStatus = .failed(error.localizedDescription)
                }
            }
        }
    }
}
