//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CreateAccountViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                renderHeader()
                    .padding(.bottom, 32)
                
                VStack(spacing: 0) {
                    renderInstructions()
                        .padding(.bottom, 8)
                    
                    renderFields()
                        .padding(.bottom, 32)
                    
                    renderButtons()
                }

                Spacer()
            }
            .navigationBarHidden(true)
            .padding(32)
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateToCodeEntry) {
                CodeEntryView(email: viewModel.email)
            }
        }
    }

    @ViewBuilder private func renderHeader() -> some View {
        VStack(spacing: 24) {
            Image(.logo)
                .resizeAndFit()
                .frame(height: 120)
            Text("Create Account")
                .appSubtitleStyle()
        }
    }

    @ViewBuilder private func renderInstructions() -> some View {
        HStack {
            Text("Enter your name and email to get started.")
                .appCaptionStyle()
                .foregroundStyle(.appSecondaryText)
            Spacer()
        }
    }

    @ViewBuilder private func renderFields() -> some View {
        VStack(spacing: 16) {
            AppField(
                placeholder: "Name",
                text: $viewModel.name
            )

            AppField(
                placeholder: "Email Address",
                text: $viewModel.email,
                type: .email
            )
        }
    }

    @ViewBuilder private func renderButtons() -> some View {
        let isDisabled = viewModel.name.trimmingCharacters(in: .whitespaces).isEmpty ||
                         viewModel.email.trimmingCharacters(in: .whitespaces).isEmpty
        ActionButton(title: "Create Account") {
            Task {
                await viewModel.submit()
            }
        }
        .opacity(isDisabled ? 0.5 : 1.0)
        .disabled(isDisabled)
        .padding(.bottom, 48)
        
        LinkButton(title: "Already have an account?") {
            dismiss()
        }
    }
}

#Preview {
    CreateAccountView()
}
