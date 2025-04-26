//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel = ProfileViewModel()
    @State private var showLogoutConfirmation = false
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                VStack(spacing: 0) {
                    renderProfile()
                    Separator()
                    renderLogout()
                    Spacer()
                }
                .padding()
            }
            .navigationBar(
                title: "Profile",
                leadingItem: {
                    renderNavButton()
                },
                allowsBackButton: false
            )
            .alert("Are you sure you want to log out?", isPresented: $showLogoutConfirmation) {
                Button("Logout", role: .destructive) {
                    viewModel.logout()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    @ViewBuilder private func renderProfile() -> some View {
        VStack(spacing: 24) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundStyle(.appFieldPlaceholder)
            
            Text(viewModel.username)
                .appTitleStyle()
                .foregroundStyle(.appText)
        }
        .padding(24)
    }
    
    @ViewBuilder private func renderLogout() -> some View {
        LinkButton(title: "Logout") {
            showLogoutConfirmation = true
        }
    }
    
    @ViewBuilder private func renderNavButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .fontWeight(.semibold)
        }
        .tint(.brand)
    }
}

#Preview {
    ProfileView()
}
