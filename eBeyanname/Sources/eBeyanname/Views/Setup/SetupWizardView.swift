import SwiftUI

struct SetupWizardView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack(spacing: 0) {
            // Sidebar: step list
            VStack(alignment: .leading, spacing: 0) {
                Text("Kurulum")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 12)

                ForEach(SetupStep.allCases) { step in
                    StepRowView(step: step, currentStep: appState.currentSetupStep)
                }

                Spacer()
            }
            .frame(width: 180)
            .background(.quaternary)

            Divider()

            // Main content area
            VStack {
                stepView(for: appState.currentSetupStep)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .id(appState.currentSetupStep)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut(duration: 0.25), value: appState.currentSetupStep)
        }
    }

    @ViewBuilder
    private func stepView(for step: SetupStep) -> some View {
        switch step {
        case .welcome:   WelcomeStepView()
        case .java:      JavaStepView()
        case .akia:      AkiaStepView()
        case .bdp:       BDPDownloadStepView()
        case .lucaProxy: LucaProxyStepView()
        case .complete:  CompleteStepView()
        }
    }
}

private struct StepRowView: View {
    let step: SetupStep
    let currentStep: SetupStep

    private var state: RowState {
        if step.rawValue < currentStep.rawValue { return .done }
        if step == currentStep { return .active }
        return .pending
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
                .frame(width: 18)

            Text(step.title)
                .font(.subheadline)
                .fontWeight(state == .active ? .semibold : .regular)
                .foregroundStyle(state == .pending ? .secondary : .primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(state == .active ? Color.accentColor.opacity(0.12) : .clear)
    }

    private var iconName: String {
        switch state {
        case .done:    return "checkmark.circle.fill"
        case .active:  return step.systemImage
        case .pending: return "circle"
        }
    }

    private var iconColor: Color {
        switch state {
        case .done:    return .green
        case .active:  return .accentColor
        case .pending: return .secondary
        }
    }

    private enum RowState { case done, active, pending }
}
