import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    @State private var showConsole = false
    @State private var showUpdates = false

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "doc.text.fill")
                    .font(.title2)
                    .foregroundStyle(Color.accentColor)
                Text("eBeyanname")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()

                Button {
                    showUpdates = true
                } label: {
                    Label("Güncellemeler", systemImage: "arrow.clockwise.circle")
                        .font(.callout)
                }
                .buttonStyle(.bordered)

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
                StatusDot(label: "Java", status: appState.javaStatus) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Java Kurulu Değil")
                            .font(.caption.bold())
                        Text("eBeyanname çalışmak için Java gerektirir.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Divider()
                        Button("Java İndir") {
                            NSWorkspace.shared.open(URL(string: "https://www.java.com/en/download/")!)
                        }
                        .buttonStyle(.link)
                        Button("Tekrar Kontrol Et") {
                            appState.javaStatus = .checking
                            Task {
                                try? await Task.sleep(nanoseconds: 300_000_000)
                                await MainActor.run {
                                    appState.javaStatus = JavaService.shared.isInstalled ? .installed : .notInstalled
                                }
                            }
                        }
                        .buttonStyle(.link)
                    }
                    .padding(8)
                    .frame(width: 200)
                }
                StatusDot(label: "Akia", status: appState.akiaStatus) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Akia Sürücüsü Kurulu Değil")
                            .font(.caption.bold())
                        Text("Mali mühür için PKCS#11 kütüphanesi gereklidir.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Divider()
                        Button("Akia Sürücüsünü Kur") { installAkia() }
                            .buttonStyle(.link)
                    }
                    .padding(8)
                    .frame(width: 220)
                }
                StatusDot(label: "BDP", status: appState.bdpStatus) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("eBeyanname Kurulu Değil")
                            .font(.caption.bold())
                        Text("GİB sunucusundan indirilecek.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Divider()
                        Button("İndir ve Kur") { downloadBDP() }
                            .buttonStyle(.link)
                    }
                    .padding(8)
                    .frame(width: 200)
                }
                if appState.lucaProxyStatus != .unchecked {
                    StatusDot(label: "Luca", status: appState.lucaProxyStatus) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Luca Proxy Kurulu Değil")
                                .font(.caption.bold())
                            Text("Luca muhasebe programı için proxy kurulumu.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Divider()
                            Button("Luca Proxy Kur") { installLucaProxy() }
                                .buttonStyle(.link)
                        }
                        .padding(8)
                        .frame(width: 220)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color(nsColor: .windowBackgroundColor))

            Divider()

            // Launch section
            VStack(spacing: 16) {
                Spacer()
                if appState.isBDPRunning {
                    VStack(spacing: 12) {
                        ProgressView().scaleEffect(0.8)
                        Text("eBeyanname çalışıyor...")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Button("Kapat") { stopBDP() }
                            .buttonStyle(.bordered)
                    }
                } else {
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
                Spacer()
            }
            .frame(maxWidth: .infinity)

            HStack {
                Spacer()
                Link(destination: URL(string: "https://furkanarici.com")!) {
                    HStack(spacing: 4) {
                        Image(systemName: "globe")
                        Text("furkanarici.com")
                    }
                    .font(.caption)
                    .foregroundStyle(Color.accentColor)
                }
                .onHover { hovering in
                    if hovering {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)

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
        .sheet(isPresented: $showUpdates) {
            UpdatesView()
                .environmentObject(appState)
        }
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

    private func refreshStatuses() {
        appState.javaStatus = JavaService.shared.isInstalled ? .installed : .notInstalled
        appState.akiaStatus = AkiaService.shared.isLibraryInstalled ? .installed : .notInstalled
        appState.bdpStatus = BDPService.shared.isInstalled ? .installed : .notInstalled
        appState.lucaProxyStatus = LucaProxyService.shared.isInstalled ? .installed : .notInstalled
    }

    private func installAkia() {
        Task {
            do {
                await MainActor.run { appState.akiaStatus = .installing }
                try AkiaService.shared.installLibrary()
                await MainActor.run { appState.akiaStatus = .downloading(0) }
                try await AkiaService.shared.installDriver { progress in
                    Task { @MainActor in appState.akiaStatus = .downloading(progress) }
                }
                await MainActor.run { appState.akiaStatus = .installed }
            } catch {
                await MainActor.run { appState.akiaStatus = .failed(error.localizedDescription) }
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
                await MainActor.run { appState.bdpStatus = .installed }
            } catch {
                await MainActor.run { appState.bdpStatus = .failed(error.localizedDescription) }
            }
        }
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
                await MainActor.run { appState.lucaProxyStatus = .failed(error.localizedDescription) }
            }
        }
    }
}

private struct StatusDot<PopoverContent: View>: View {
    let label: String
    let status: ComponentStatus
    @ViewBuilder let popoverContent: () -> PopoverContent
    @State private var showPopover = false

    private var isActionable: Bool {
        switch status {
        case .notInstalled, .failed: return true
        default: return false
        }
    }

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(dotColor)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            if isActionable { showPopover = true }
        }
        .onHover { hovering in
            if isActionable {
                if hovering { NSCursor.pointingHand.push() } else { NSCursor.pop() }
            }
        }
        .popover(isPresented: $showPopover, arrowEdge: .bottom) {
            popoverContent()
        }
    }

    private var dotColor: Color {
        switch status {
        case .installed:             return .green
        case .notInstalled, .failed: return .red
        default:                     return .gray
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
            .onChange(of: output) { _ in
                proxy.scrollTo("bottom", anchor: .bottom)
            }
        }
    }
}
