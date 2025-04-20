//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

extension Image {
    
    func resizeAndFill() -> some View {
        self
            .resizable()
            .scaledToFill()
    }
    
    func resizeAndFit() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
}
