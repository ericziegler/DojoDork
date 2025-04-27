//
// Created by Eric Ziegler on 4/19/25
//  

import SwiftUI

// MARK: - Custom Fonts

extension Font {
 
    private static func bernhardGothic(size: Double) -> Font {
        .custom("OPTIBernhardGothic-XHeavy", size: size)
    }
    
}

// MARK: - App Fonts

extension Font {
    
    static var appLargeTitle: Font {
        .bernhardGothic(size: 48)
    }
    
    static var appTitle: Font {
        .bernhardGothic(size: 28)
    }
    
    static var appNav: Font {
        .system(size: 24, weight: .semibold)
    }
    
    static var appLargeHeader: Font {
        .system(size: 34, weight: .semibold)
    }
    
    static var appHeader: Font {
        .system(size: 28, weight: .medium)
    }
    
    static var appSubtitle: Font {
        .system(size: 22, weight: .medium)
    }
    
    static var appBody: Font {
        .system(size: 19, weight: .regular)
    }
    
    static var appBodyMedium: Font {
        .system(size: 19, weight: .medium)
    }
    
    static var appCaption: Font {
        .system(size: 16, weight: .medium)
    }
    
    static var appButton: Font {
        .system(size: 21, weight: .semibold)
    }
    
    static var appLink: Font {
        .system(size: 21, weight: .semibold)
    }
    
}

#Preview {
    VStack {
        Text("Title")
            .appTitleStyle()
        
        Text("Large Header")
            .appLargeHeaderStyle()
        
        Text("Header")
            .appHeaderStyle()
        
        Text("Subtitle")
            .appSubtitleStyle()
        
        Text("Body")
            .appBodyStyle()
        
        Text("Body Medium")
            .appBodyMediumStyle()
        
        Text("Caption")
            .appCaptionStyle()
        
        Text("Button")
            .appButtonStyle()
    }
}
