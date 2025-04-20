//
// Created by Eric Ziegler on 4/19/25
//  

import SwiftUI

struct SolidBackground<Content: View>: View {

    var color: Color = .appBackground
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            HStack(content: content)
        }
    }
}

#Preview {
    SolidBackground {
        Text("Hello!")
    }
}
