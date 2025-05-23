//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

enum TextFieldType {
    case email
    case password
    case plain
    case title
    case search
    case number
    case name

    var autocapitalization: UITextAutocapitalizationType {
        switch self {
        case .email, .password, .number, .search:
            return .none
        case .title:
            return .words
        case .plain, .name:
            return .sentences
        }
    }

    var disableAutocorrection: Bool {
        switch self {
        case .email, .password, .number, .name:
            return true
        case .plain, .search, .title:
            return false
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .password, .plain, .search, .title, .name:
            return .default
        case .number:
            return .numberPad
        }
    }

    var textContentType: UITextContentType? {
        switch self {
        case .email:
            return .emailAddress
        case .password:
            return .password
        case .plain, .number, .search, .title, .name:
            return nil
        }
    }
}

struct AppField: View {
    @Environment(\.colorScheme) var colorScheme
    
    let placeholder: String
    @Binding var text: String

    private let placeholderColor: Color = .appFieldPlaceholder
    private let textColor: Color = .appFieldText
    private let bgColor: Color = .appField
    var type: TextFieldType = .plain

    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder).foregroundColor(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.9)
                }
                .frame(minHeight: 35)
                .appBodyStyle()
                .foregroundStyle(textColor)
                .autocapitalization(type.autocapitalization)
                .disableAutocorrection(type.disableAutocorrection)
                .keyboardType(type.keyboardType)
                .textContentType(type.textContentType)
  
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }, label: {
                    ZStack {
                        Circle()
                            .fill(textColor.opacity(0.1))
                            .frame(width: 26, height: 26)
                        Image(systemName: "xmark")
                            .frame(width: 8, height: 8)
                            .foregroundStyle(textColor.opacity(0.5))
                    }
                })
            }
        }
        .padding()
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.appBorder, lineWidth: 1)
        )
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    
    @Previewable @State var text: String = ""
    
    SolidBackground {
        AppField(placeholder: "Enter text here", text: $text)
            .padding()
    }
    
}
