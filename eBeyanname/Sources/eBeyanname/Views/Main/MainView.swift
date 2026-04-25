import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @State private var showConsole = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "doc.text.fill")
                    .font(.title2)
                    .foregroundStyle(.accentColor)
                Text("eBeyanname")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()

                if appState.bdpUpdateAvailable {
                    Button {
                        Task { await updateBDP() }
                    } label: {
                        Label("Güncelleme Var", systemImage: "arrow.clockwise.circle.fill")
                            .foregroundStyle(.orange)
                    }
                    .buttonStyle(.bordered)
                }

                Button {
                    showConsole.toggle()
                } label: {
                    Image(systemName: showConsole ? "terminal.fill" : "terminal")
                }
                .buttonStyle(.plain)
                .help("Konsol çıktısını göster/gizle")
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(.ultraThinMaterial)

            Divider()

            // Status bar
            HStack(spacing: 24) {
                StatusDot(label: "Java", status: appState.javaStatus)
                StatusDot(label: "Akia", status: appState.akiaStatus)
                StatusDot(label: "BDP", status: appState.bdpStatus)
                if appState.lucaProxyStatus != .unchecked {
                    StatusDot(label: "Luca", status: appState.lucaProxyStatus)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color(nsColor: .windowBackgroundColor))

            Divider()

            // Main content
            VStack(spacing: 28) {
                Spacer()

                if appState.isBDPRunning {
                    VStack(spacing: 12) {
                        ProgressView()
                            .scaleEffect(0.8)
                        Text("eBeyanname çalışıyor...")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Button("Kapat") { stopBDP() }
                            .buttonStyle(.bordered)
                    }
                } else {
                    VStack(spacing: 16) {
                        Button {
                            launchBDP()
                        } label: {
                            Label("eBeyanname'yi Başlat", systemImage: "play.fill")
                                .font(.title3)
                                .frame(width: 240)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!BDPService.shared.isInstalled || !JavaService.shared.isInstalled)
                    }
                }

                Spacer()
            }

            // Console drawer
            if showConsole {
                Divider()
                ConsoleView(output: appState.bdpOutput)
                    .frame(height: 160)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showConsole)
        .onAppear { refreshStatuses() }
    }

    private func launchBDP() {
        do {
            try BDPService.shared.launch { text in
                Task { @MainActor in appState.appendBDPOutput(text) }
            }
            appState.isBDPRunning = true
        } catch {
            appState.appendBDPOutput("[Hata] \(error.localizedDescription)\n")
        }
    }

    private func stopBDP() {
        BDPService.shared.terminate()
        appState.isBDPRunning = false
    }

    private func updateBDP() async {
        appState.bdpStatus = .downloading(0)
        do {
            try await BDPService.shared.download { progress in
                Task { @MainActor in appState.bdpStatus = .downloading(progress) }
            }
            appState.bdpStatus = .installed
            appState.bdpUpdateAvailable = false
        } catch {
            appState.bdpStatus = .failed(error.localizedDescription)
        }
    }

    private func refreshStatuses() {
        appState.javaStatus = JavaService.shared.isInstalled ? .installed : .notInstalled
        appState.akiaStatus = AkiaService.shared.isLibraryInstalled ? .installed : .notInstalled
        appState.bdpStatus = BDPService.shared.isInstalled ? .installed : .notInstalled
        appState.lucaProxyStatus = LucaProxyService.shared.isInstalled ? .installed : .notInstalled
    }
}

private struct StatusDot: View {
    let label: String
    let status: ComponentStatus

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(dotColor)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var dotColor: Color {
        switch status {
        case .installed:  return .green
        case .notInstalled, .failed: return .red
        default:          return .gray
        }
    }
}

private struct ConsoleView: View {
    let output: String

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Text(output.isEmpty ? "Konsol çıktısı burada görünecek..." : output)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(output.isEmpty ? .secondary : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .id("bottom")
            }
            .background(Color(nsColor: .textBackgroundColor))
            .onChange(of: output) { _, _ in
                proxy.scrollTo("bottom", anchor: .bottom)
            }
        }
    }
}
