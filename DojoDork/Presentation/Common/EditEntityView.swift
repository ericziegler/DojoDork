//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct EditEntityView: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    var header: String?
    var placeholder: String = ""
    var textFieldType = TextFieldType.plain
    var saveButtonText = "Save"
    var destructiveButtonText: String? = nil
    var onSaveAction: ((String) -> Void)?
    var onDestructiveAction: (() -> Void)?
    
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                renderHeader()
                renderField()
                renderActionButton()
                renderDestructiveButton()
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 64)
            .navigationBar(title: title, leadingItem: {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .appBodyMediumStyle()
                        .foregroundStyle(.brand)
                }

            }, allowsBackButton: false
            )
        }
    }
    
    @ViewBuilder private func renderHeader() -> some View {
        if let header {
            HStack {
                Text(header)
                    .appHeaderStyle()
                    .foregroundStyle(.appText)
                Spacer()
            }
            .padding(.bottom, 8)
        }
    }
    
    @ViewBuilder private func renderField() -> some View {
        AppField(placeholder: placeholder, text: $text, type: textFieldType)
            .padding(.bottom, 24)
    }
    
    @ViewBuilder private func renderActionButton() -> some View {
        ActionButton(title: saveButtonText) {
            onSaveAction?(text)
            dismiss()
        }
        .padding(.bottom, 80)
    }
    
    @ViewBuilder private func renderDestructiveButton() -> some View {
        if let destructiveButtonText {
            LinkButton(title: destructiveButtonText, color: .appError) {
                onDestructiveAction?()
            }
        }
    }
}

#Preview {
    EditEntityView(title: "Edit", header: "Enter the name", placeholder: "Name", saveButtonText: "Save Me", destructiveButtonText: "Delete Me") { updatedText in
        
    } onDestructiveAction: {
        
    }
}
