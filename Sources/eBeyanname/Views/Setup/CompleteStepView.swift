import SwiftUI

struct CompleteStepView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 72))
                .foregroundStyle(.green)

            VStack(spacing: 12) {
                Text("Kurulum Tamamlandı!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("eBeyanname kullanıma hazır. Uygulamayı başlatmak için aşağıdaki butona tıklayın.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 380)
            }

            Button {
                appState.markSetupComplete()
            } label: {
                Label("eBeyanname'yi Başlat", systemImage: "play.fill")
                    .frame(width: 220)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Spacer()
        }
        .padding(40)
    }
}
