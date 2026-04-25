import SwiftUI

struct WelcomeStepView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "doc.text.fill")
                .font(.system(size: 64))
                .foregroundStyle(.accentColor)

            VStack(spacing: 12) {
                Text("eBeyanname'ye Hoş Geldiniz")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Bu uygulama, Gelir İdaresi Başkanlığı eBeyanname programını Mac bilgisayarınızda kolayca kullanmanızı sağlar.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 400)
            }

            VStack(alignment: .leading, spacing: 14) {
                FeatureRow(icon: "checkmark.shield.fill", text: "Gerekli bileşenler otomatik kurulur")
                FeatureRow(icon: "arrow.clockwise.circle.fill", text: "Güncellemeler uygulama içinden yapılır")
                FeatureRow(icon: "play.fill", text: "Tek tıkla eBeyanname başlatılır")
            }

            Spacer()

            Button {
                withAnimation { appState.currentSetupStep = .java }
            } label: {
                Text("Kuruluma Başla")
                    .frame(width: 200)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Spacer()
        }
        .padding(40)
    }
}

private struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.accentColor)
                .frame(width: 24)
            Text(text)
                .font(.callout)
        }
    }
}
