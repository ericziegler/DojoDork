//
// Created by Eric Ziegler on 4/19/25
//  

import SwiftUI

// MARK: - Modifiers

private struct AppNavStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appNav)
            .textCase(.uppercase)
    }
}

private struct AppTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appTitle)
    }
}

private struct AppHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appHeader)
    }
}

private struct AppSubtitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appSubtitle)
            .textCase(.uppercase)
            .tracking(2)
    }
}

private struct AppBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appBody)
    }
}

private struct AppBodyMediumStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appBodyMedium)
    }
}

private struct AppCaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appCaption)
    }
}

private struct AppButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appButton)
            .textCase(.uppercase)
    }
}

private struct AppLinkStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appLink)
    }
}

// MARK: - View Extensions

extension View {
    func appNavStyle() -> some View {
        modifier(AppNavStyle())
    }
    
    func appTitleStyle() -> some View {
        modifier(AppTitleStyle())
    }
    
    func appHeaderStyle() -> some View {
        modifier(AppHeaderStyle())
    }

    func appSubtitleStyle() -> some View {
        modifier(AppSubtitleStyle())
    }

    func appBodyStyle() -> some View {
        modifier(AppBodyStyle())
    }

    func appBodyMediumStyle() -> some View {
        modifier(AppBodyMediumStyle())
    }

    func appCaptionStyle() -> some View {
        modifier(AppCaptionStyle())
    }

    func appButtonStyle() -> some View {
        modifier(AppButtonStyle())
    }
    
    func appLinkStyle() -> some View {
        modifier(AppLinkStyle())
    }
}
