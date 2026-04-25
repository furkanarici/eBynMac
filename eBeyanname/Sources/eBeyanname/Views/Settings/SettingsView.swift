import SwiftUI
import Sparkle

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    let updater: SPUUpdater
    @State private var isUpdatingBDP = false
    @State private var updateMessage: String?

    var body: some View {
        TabView {
            generalTab
                .tabItem { Label("Genel", systemImage: "gearshape") }

            componentsTab
                .tabItem { Label("Bileşenler", systemImage: "puzzlepiece") }

            aboutTab
                .tabItem { Label("Hakkında", systemImage: "info.circle") }
        }
        .padding(20)
        .frame(width: 460, height: 320)
    }

    // MARK: - Tabs

    private var generalTab: some View {
        Form {
            Section("Otomatik Güncellemeler") {
                Toggle("Uygulama güncellemelerini otomatik kontrol et",
                       isOn: Binding(
                           get: { updater.automaticallyChecksForUpdates },
                           set: { updater.automaticallyChecksForUpdates = $0 }
                       ))

                Button("Şimdi Kontrol Et") {
                    updater.checkForUpdates()
                }
            }

            Section("eBeyanname (BDP) Güncellemesi") {
                if isUpdatingBDP {
                    HStack {
                        ProgressView()
                            .scaleEffect(0.7)
                        Text("Güncelleniyor...")
                            .font(.callout)
                    }
                } else {
                    Button("BDP'yi Güncelle") { updateBDP() }
                }

                if let msg = updateMessage {
                    Text(msg)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .formStyle(.grouped)
    }

    private var componentsTab: some View {
        Form {
            Section("Kurulu Bileşenler") {
                ComponentRow(label: "Java", status: appState.javaStatus)
                ComponentRow(label: "Akia PKCS#11", status: appState.akiaStatus)
                ComponentRow(label: "BDP Dosyaları", status: appState.bdpStatus)
                ComponentRow(label: "Luca Proxy", status: appState.lucaProxyStatus)
            }

            Section("Sıfırlama") {
                Button("Kurulum Sihirbazını Yeniden Çalıştır") {
                    appState.resetSetup()
                }
                .foregroundStyle(.red)
            }
        }
        .formStyle(.grouped)
    }

    private var aboutTab: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text.fill")
                .font(.system(size: 48))
                .foregroundStyle(.accentColor)

            VStack(spacing: 4) {
                Text("eBeyanname")
                    .font(.headline)
                Text("Sürüm \(Bundle.main.shortVersion)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text("Gelir İdaresi Başkanlığı eBeyanname programı için macOS istemcisi.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Actions

    private func updateBDP() {
        isUpdatingBDP = true
        updateMessage = nil
        Task {
            do {
                try await BDPService.shared.download { progress in
                    Task { @MainActor in appState.bdpStatus = .downloading(progress) }
                }
                await MainActor.run {
                    appState.bdpStatus = .installed
                    isUpdatingBDP = false
                    updateMessage = "BDP başarıyla güncellendi."
                }
            } catch {
                await MainActor.run {
                    isUpdatingBDP = false
                    updateMessage = "Hata: \(error.localizedDescription)"
                }
            }
        }
    }
}

private struct ComponentRow: View {
    let label: String
    let status: ComponentStatus

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Image(systemName: status.symbolName)
                .foregroundStyle(iconColor)
            Text(status.statusText)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var iconColor: Color {
        switch status {
        case .installed:          return .green
        case .notInstalled, .failed: return .red
        default:                  return .secondary
        }
    }
}

private extension Bundle {
    var shortVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}
