import SwiftUI

struct UpdatesView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var isBDPUpdating = false
    @State private var bdpMessage: String?
    @StateObject private var checkForUpdatesViewModel = CheckForUpdatesViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Güncellemeler")
                    .font(.headline)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(20)

            Divider()

            // BDP update row
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Image(systemName: "arrow.down.circle")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 32)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("eBeyanname (BDP)")
                            .fontWeight(.semibold)
                        Text("GİB sunucusundan son sürümü indir ve yükle.")
                            .font(.callout)
                            .foregroundStyle(.secondary)

                        if case .downloading(let p) = appState.bdpStatus {
                            ProgressView(value: p)
                                .padding(.top, 4)
                            Text("%\(Int(p * 100)) indiriliyor...")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        if let msg = bdpMessage {
                            Text(msg)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding(.top, 2)
                        }
                    }

                    Spacer()

                    if isBDPUpdating {
                        ProgressView().scaleEffect(0.8)
                    } else {
                        Button("Güncelle") {
                            Task { await updateBDP() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding(20)

            Divider()

            // App update row
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Image(systemName: "app.badge.checkmark")
                        .font(.title2)
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 32)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Uygulama Güncellemesi")
                            .fontWeight(.semibold)
                        Text("eBeyanname uygulamasının yeni sürümünü kontrol et.")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button("Kontrol Et") {
                        appState.updaterController.updater.checkForUpdates()
                    }
                    .buttonStyle(.bordered)
                    .disabled(!checkForUpdatesViewModel.canCheckForUpdates)
                }
            }
            .padding(20)

            Spacer()
        }
        .frame(width: 420, height: 300)
        .onAppear {
            checkForUpdatesViewModel.bind(to: appState.updaterController.updater)
        }
    }

    private func updateBDP() async {
        isBDPUpdating = true
        bdpMessage = nil
        appState.bdpStatus = .downloading(0)
        do {
            try await BDPService.shared.download { progress in
                Task { @MainActor in appState.bdpStatus = .downloading(progress) }
            }
            appState.bdpStatus = .installed
            bdpMessage = "Güncelleme tamamlandı."
        } catch {
            appState.bdpStatus = .installed
            bdpMessage = "Hata: \(error.localizedDescription)"
        }
        isBDPUpdating = false
    }
}
