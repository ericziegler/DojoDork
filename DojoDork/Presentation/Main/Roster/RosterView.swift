//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct RosterView: View {
    
    @State private var viewModel = RosterViewModel()
    @Binding var showProfile: Bool
    
    var body: some View {
        NavigationStack {
            SolidBackground {
                Text("Roster")
            }
            .navigationBar(title: "Roster", leadingItem: {
                renderNavButton()
            })
        }
    }
    
    @ViewBuilder private func renderNavButton() -> some View {
        Button {
            showProfile.toggle()
        } label: {
            Image(systemName: "gearshape.fill")
                .fontWeight(.semibold)
        }
        .tint(.brand)
    }
}

#Preview {
    RosterView(showProfile: .constant(false))
}
