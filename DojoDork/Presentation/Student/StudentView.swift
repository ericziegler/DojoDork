//
// Created by Eric Ziegler on 4/26/25
//  

import SwiftUI

struct StudentView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: StudentViewModel
    @State private var isEditing = false
    @State private var showDeleteAlert = false
    @State private var showDatePicker = false
    
    var onStudentUpdated: ((_ studentId: String) -> Void)?
    var onStudentPromoted: ((_ studentId: String) -> Void)?
    var onStudentDeleted: (() -> Void)?

    init(
        student: Student,
        onStudentUpdated: ((_ studentId: String) -> Void)?,
        onStudentPromoted: ((_ studentId: String) -> Void)?,
        onStudentDeleted: (() -> Void)?
    ) {
        _viewModel = State(wrappedValue: StudentViewModel(student: student))
        self.onStudentUpdated = onStudentUpdated
        self.onStudentPromoted = onStudentPromoted
        self.onStudentDeleted = onStudentDeleted
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
                            onStudentDeleted?()
                            dismiss()
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Are you sure you want to delete this student?")
                }
                .sheet(isPresented: $showDatePicker) {
                    DatePickerView() { date in
                        Task {
                            await viewModel.promoteStudent(date: date)
                            onStudentPromoted?(viewModel.studentId)
                            dismiss()
                        }
                    }
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
                showDatePicker = true
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
                    onStudentUpdated?(viewModel.studentId)
                    dismiss()
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
    StudentView(student: .mockData) { studentId in
        
    } onStudentPromoted: { studentId in
        
    } onStudentDeleted: {
        
    }

}
