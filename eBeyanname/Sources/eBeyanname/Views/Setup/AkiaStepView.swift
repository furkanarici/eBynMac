import SwiftUI

struct AkiaStepView: View {
    @EnvironmentObject var appState: AppState
    @State private var downloadProgress: Double = 0
    @State private var waitingForUserToFinishDMG = false
    @State private var errorMessage: String?

    var body: some View {
        StepContainerView(
            title: "Akia Akıllı Kart Sürücüsü",
            subtitle: "Mali mühürün çalışması için Akia sürücüsü gereklidir.",
            systemImage: "creditcard.fill"
        ) {
            switch appState.akiaStatus {
            case .unchecked:
                Button("Akia Durumunu Kontrol Et") { checkAkia() }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)

            case .checking:
                ProgressView("Kontrol ediliyor...")

            case .installed:
                StatusBanner(
                    icon: "checkmark.circle.fill",
                    color: .green,
                    title: "Akia Sürücüsü Kurulu",
                    message: "PKCS#11 kütüphanesi mevcut."
                )
                nextButton

            case .notInstalled:
                VStack(spacing: 16) {
                    StatusBanner(
                        icon: "exclamationmark.circle.fill",
                        color: .orange,
                        title: "Akia Sürücüsü Gerekli",
                        message: "PKCS#11 kütüphanesi kurulacak ve tam sürücü indirilecek."
                    )
                    Button("Akia Sürücüsünü Kur") { installAkia() }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }

            case .installing:
                VStack(spacing: 12) {
                    ProgressView("PKCS#11 kütüphanesi kopyalanıyor...")
                }

            case .downloading(let p):
                VStack(spacing: 12) {
                    ProgressView("Akia sürücüsü indiriliyor...", value: p)
                    Text("%\(Int(p * 100))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

            case .failed(let msg):
                VStack(spacing: 12) {
                    StatusBanner(icon: "xmark.circle.fill", color: .red, title: "Hata", message: msg)
                    Button("Tekrar Dene") { installAkia() }
                        .buttonStyle(.borderedProminent)
                }
            }

            if waitingForUserToFinishDMG {
                VStack(spacing: 16) {
                    Divider()
                    Text("Akia yükleyici açıldı. Kurulumu tamamladıktan sonra devam edin.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    nextButton
                }
            }
        }
        .onAppear { if appState.akiaStatus == .unchecked { checkAkia() } }
    }

    private var nextButton: some View {
        Button("Devam Et") {
            withAnimation { appState.currentSetupStep = .bdp }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    private func checkAkia() {
        appState.akiaStatus = .checking
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            await MainActor.run {
                appState.akiaStatus = AkiaService.shared.isLibraryInstalled ? .installed : .notInstalled
            }
        }
    }

    private func installAkia() {
        Task {
            do {
                // Step 1: Copy PKCS#11 library (needs admin)
                await MainActor.run { appState.akiaStatus = .installing }
                try AkiaService.shared.installLibrary()

                // Step 2: Download and open full driver DMG
                await MainActor.run { appState.akiaStatus = .downloading(0) }
                try await AkiaService.shared.installDriver { progress in
                    Task { @MainActor in
                        appState.akiaStatus = .downloading(progress)
                    }
                }

                await MainActor.run {
                    appState.akiaStatus = .installed
                    waitingForUserToFinishDMG = true
                }
            } catch {
                await MainActor.run {
                    appState.akiaStatus = .failed(error.localizedDescription)
                }
            }
        }
    }
}
