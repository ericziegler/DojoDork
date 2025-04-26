//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct ProfileView: View {
    
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        Text("Profile")
    }
}

#Preview {
    ProfileView()
}
