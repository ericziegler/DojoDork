//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct ActionButton: View {
    let title: String
    var systemImage: String?
    let action: () -> Void
    
    @State private var hapticFeedback = false

    var body: some View {
        Button(action: {
            action()
            hapticFeedback.toggle()
        }) {
            HStack(spacing: 8) {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                        .imageScale(.medium)
                        .fontWeight(.semibold)
                }
                Text(title)
                    .appButtonStyle()
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.brand)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(.brand, lineWidth: 3)
            )
        }
        .sensoryFeedback(.impact, trigger: hapticFeedback)
    }
}

#Preview {
    SolidBackground {
        VStack {
            ActionButton(title: "Add student", systemImage: "plus") {
                
            }
        }
        .padding()
    }
}
