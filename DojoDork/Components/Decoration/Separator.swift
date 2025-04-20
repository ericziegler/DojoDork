//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct Separator: View {
 
    var body: some View {
        Rectangle()
            .fill(Color.appSeparator)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    SolidBackground {
        VStack {
            Spacer()
            Separator()
            Spacer()
        }
        .padding()
    }
}
