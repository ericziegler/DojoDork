//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct LinkButton: View {
    let title: String
    var color: Color = .brand
    let action: () -> Void
    
    @State private var hapticFeedback = false

    var body: some View {
        Button(action: {
            action()
            hapticFeedback.toggle()
        }) {
            Text(title)
                .appBodyStyle()
                .underline()
            .foregroundColor(color)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.clear)
        }
        .sensoryFeedback(.impact, trigger: hapticFeedback)
    }
}

#Preview {
    SolidBackground {
        VStack {
            LinkButton(title: "Reset password") {
                
            }
        }
        .padding()
    }
}
