//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct RequestCodeView: View {
    @State private var viewModel = RequestCodeViewModel()

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
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
            .background {
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
            Text("Dojo Dork")
                .appSubtitleStyle()
        }
    }
    
    @ViewBuilder private func renderInstructions() -> some View {
        HStack {
            Text("Existing users: enter your email address to receive a code.")
                .appCaptionStyle()
                .foregroundStyle(.appSecondaryText)
            Spacer()
        }
    }
    
    @ViewBuilder private func renderField() -> some View {
        AppField(
            placeholder: "Email Address",
            text: $viewModel.email,
            type: .email
        )
    }
    
    @ViewBuilder private func renderButtons() -> some View {
        ActionButton(title: "Send Code") {
            Task {
                await viewModel.submitEmail()
            }
        }
        .padding(.bottom, 48)
        
        NavigationLink(destination: CreateAccountView(), label: {
            Text("Need an account?")
                .appBodyStyle()
                .foregroundStyle(.brand)
                .underline()
        })
    }
}

#Preview {
    RequestCodeView()
}
