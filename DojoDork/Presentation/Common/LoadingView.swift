//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI
import SwiftfulLoadingIndicators

struct LoadingView: View {
    
    var text: String?
    
    var body: some View {
        ZStack {
            renderBackground()
            renderLoadingIndicator()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder private func renderBackground() -> some View {
        Rectangle()
            .fill(.black.opacity(0.64))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder private func renderLoadingIndicator() -> some View {
        VStack(spacing: 28) {
            LoadingIndicator(animation: .threeBallsTriangle, color: .brand, size: .medium)
            if let text {
                Text(text)
                    .appSubtitleStyle()
                    .foregroundStyle(.appText)
            }
        }
    }
}

#Preview {
    ZStack {
        SolidBackground {
            Text("Testing")
                .appSubtitleStyle()
                .foregroundStyle(.appText)
        }
        LoadingView(text: "Loading...")
    }
}
