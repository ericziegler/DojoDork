//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct CodeEntryView: View {
    @Environment(\.dismiss) private var dismiss
    
    let email: String
    @State private var viewModel: CodeEntryViewModel

    init(email: String) {
        self.email = email
        _viewModel = State(initialValue: CodeEntryViewModel(email: email))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                renderHeader()
                    .padding(.bottom, 32)

                VStack(spacing: 0) {
                    renderInstructions()
                        .padding(.bottom, 8)

                    renderField()
                        .padding(.bottom, 32)

                    renderButtons()
                }

                Spacer()
            }
            .padding(32)
            .navigationBarHidden(true)
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
            .background {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
    }

    @ViewBuilder private func renderHeader() -> some View {
        VStack(spacing: 24) {
            Image(.logo)
                .resizeAndFit()
                .frame(height: 120)
            Text("Enter Code")
                .appSubtitleStyle()
        }
    }

    @ViewBuilder private func renderInstructions() -> some View {
        HStack {
            Text("Check your email for a 6-digit code.")
                .appCaptionStyle()
                .foregroundStyle(.appSecondaryText)
            Spacer()
        }
    }

    @ViewBuilder private func renderField() -> some View {
        AppField(
            placeholder: "6-digit code",
            text: $viewModel.code,
            type: .number
        )
    }

    @ViewBuilder private func renderButtons() -> some View {
        ActionButton(title: "Verify") {
            Task {
                await viewModel.submitCode()
            }
        }
        .padding(.bottom, 48)

        LinkButton(title: "Go Back") {
            dismiss()
        }
    }
}

#Preview {
    CodeEntryView(email: "test-user@dojovista.com")
}
