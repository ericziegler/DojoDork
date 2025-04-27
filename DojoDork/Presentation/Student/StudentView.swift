//
// Created by Eric Ziegler on 4/26/25
//  

import SwiftUI

struct StudentView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: StudentViewModel
    @State private var isEditing = false
    @State private var showDeleteAlert = false

    init(student: Student) {
        _viewModel = State(wrappedValue: StudentViewModel(student: student))
    }
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                VStack(spacing: 48) {
                    VStack (spacing: 12) {
                        renderName()
                        renderPromotion()
                    }
                    Separator()
                    renderAttendanceSummary()
                    Separator()
                    renderActionButton()
                    Spacer()
                }
                .padding(.top, 64)
                .padding(.horizontal, 24)
                .alert("Delete Student", isPresented: $showDeleteAlert) {
                    Button("Delete", role: .destructive) {
                        Task {
                            await viewModel.deleteStudent()
                            dismiss()
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Are you sure you want to delete this student?")
                }
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .navigationBar(
                title: isEditing ? "Edit Student" : "Student Info",
                leadingItem: {
                    renderLeadingButton()
                },
                trailingItem: {
                    renderTrailingButton()
                },
                allowsBackButton: false
            )
        }
    }
    
    @ViewBuilder private func renderName() -> some View {
        if isEditing {
            AppField(placeholder: "Student Name", text: $viewModel.name)
        } else {
            Text(viewModel.name)
                .appLargeHeaderStyle()
        }
    }
    
    @ViewBuilder private func renderPromotion() -> some View {
        Text("Last Promoted: \(viewModel.lastPromotedString)")
            .appBodyStyle()
            .foregroundColor(.secondary)
    }
    
    @ViewBuilder private func renderAttendanceSummary() -> some View {
        HStack {
            VStack {
                Text("\(viewModel.classesSincePromotion)")
                    .appLargeTitleStyle()
                    .foregroundStyle(.brand)
                Text("Since Promotion")
                    .appCaptionStyle()
            }
            Spacer()
            VStack {
                Text("\(viewModel.totalClasses)")
                    .appLargeTitleStyle()
                    .foregroundStyle(.brand)
                Text("Total Classes")
                    .appCaptionStyle()
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder private func renderActionButton() -> some View {
        if isEditing {
            ActionButton(title: "Delete Student", color: .appError) {
                showDeleteAlert = true
            }
            .padding(.top, 32)
        } else {
            ActionButton(title: "Promote Student") {
                Task {
                    await viewModel.promoteStudent()
                }
            }
            .padding(.top, 32)
        }
    }
    
    @ViewBuilder private func renderLeadingButton() -> some View {
        Button {
            if isEditing {
                isEditing = false
                viewModel.resetChanges()
            } else {
                dismiss()
            }
        } label: {
            Text(isEditing ? "Cancel" : "")
                .fontWeight(.semibold)
                .overlay(
                    isEditing ? nil : Image(systemName: "xmark").fontWeight(.semibold)
                )
        }
        .tint(.brand)
    }
    
    @ViewBuilder private func renderTrailingButton() -> some View {
        Button {
            if isEditing {
                Task {
                    await viewModel.saveChanges()
                    isEditing = false
                }
            } else {
                isEditing = true
            }
        } label: {
            Text(isEditing ? "Save" : "")
                .fontWeight(.semibold)
                .overlay(
                    isEditing ? nil : Image(systemName: "square.and.pencil").fontWeight(.semibold)
                )
        }
        .tint(.brand)
    }
}

#Preview {
    StudentView(student: .mockData)
}
