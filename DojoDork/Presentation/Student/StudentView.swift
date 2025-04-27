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
                VStack(spacing: 24) {
                    if isEditing {
                        TextField("Student Name", text: $viewModel.name)
                            .textFieldStyle(.roundedBorder)
                    } else {
                        Text(viewModel.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }

                    Text("Last Promoted: \(viewModel.lastPromotedString)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        VStack {
                            Text("\(viewModel.classesSincePromotion)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Since Promotion")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Text("\(viewModel.totalClasses)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Text("Total Classes")
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal)

                    if isEditing {
                        ActionButton(title: "Delete Student") {
                            showDeleteAlert = true
                        }
                        .foregroundStyle(.appError)
                        .padding(.top, 32)
                    } else {
                        ActionButton(title: "Promote Student") {
                            viewModel.promoteStudent()
                        }
                        .padding(.top, 32)
                    }
                    
                    Spacer()
                }
                .padding()
                .alert("Delete Student", isPresented: $showDeleteAlert) {
                    Button("Delete", role: .destructive) {
                        viewModel.deleteStudent()
                        dismiss()
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Are you sure you want to delete this student?")
                }
            }
            .navigationBar(
                title: "Student Info",
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
                viewModel.saveChanges()
                isEditing = false
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
