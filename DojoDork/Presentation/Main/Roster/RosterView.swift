//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct RosterView: View {
    
    @State private var viewModel = RosterViewModel()
    
    var body: some View {
        Text("Roster")
    }
}

#Preview {
    RosterView()
}
