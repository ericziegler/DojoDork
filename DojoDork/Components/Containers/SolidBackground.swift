//
// Created by Eric Ziegler on 4/19/25
//  

import SwiftUI

struct SolidBackground<Content: View>: View {

    // TODO: EZ - Change default color
    var color = Color.black
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
