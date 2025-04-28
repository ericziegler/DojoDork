//
// Created by Eric Ziegler on 4/27/25
//  

import SwiftUI

struct AddStudentView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = AddStudentViewModel()
    var onStudentAdded: ((_ studentId: String) -> Void)?
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                VStack() {
                    renderInstructions()
                    renderName()
                    renderActionButton()
                    Spacer()
                }
                .padding(.top, 64)
                .padding(.horizontal, 24)
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationBar(
                title: "Add Student",
                leadingItem: {
                    renderLeadingButton()
                },
                allowsBackButton: false
            )
        }
    }
    
    @ViewBuilder private func renderInstructions() -> some View {
        HStack {
            Text("Give the student a name to add them to the roster.")
                .appBodyStyle()
            Spacer()
        }
        .foregroundStyle(.appSecondaryText)
    }
    
    @ViewBuilder private func renderName() -> some View {
        AppField(placeholder: "Student Name", text: $viewModel.name)
            .padding(.bottom, 24)
    }
    
    @ViewBuilder private func renderActionButton() -> some View {
        ActionButton(title: "Add Student") {
            Task {
                do {
                    try await viewModel.createStudent()
                    onStudentAdded?(viewModel.studentId)
                    dismiss()
                } catch {
                    viewModel.showAlert(message: "We were unable to add the student at this time.")
                }
            }
        }
    }
    
    @ViewBuilder private func renderLeadingButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark").fontWeight(.semibold)
        }
    }
}

#Preview {
    AddStudentView()
}
