//
// Created by Eric Ziegler on 4/26/25
//  

import SwiftUI

struct FloatingButton: View {
    
    var systemImage: String
    let action: () -> Void
    
    @State private var hapticFeedback = false

    var body: some View {
        Button(action: {
            action()
            hapticFeedback.toggle()
        }) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .imageScale(.medium)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.appBackground)
            .padding(20)
            .background(.brand)
            .clipShape(Circle())
            .shadow(radius: 8)
        }
        .sensoryFeedback(.impact, trigger: hapticFeedback)
    }
}

#Preview {
    SolidBackground {
        VStack {
            FloatingButton(systemImage: "plus") {
                
            }
        }
        .padding()
    }
}
