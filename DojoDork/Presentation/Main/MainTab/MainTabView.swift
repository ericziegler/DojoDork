//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                renderTab(view: AttendanceView(), tab: .attendance)
                renderTab(view: RosterView(), tab: .roster)
                renderTab(view: ProfileView(), tab: .profile)
            }
            .toolbarBackground(Color.appBar, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(.brand)
    }
    
    @ViewBuilder private func renderTab(view: some View, tab: Tab) -> some View {
        view
            .tag(tab.rawValue)
            .tabItem {
                Image(systemName: tab.imageName)
                Text(tab.text)
                    .appNavStyle()
            }
    }
}

#Preview {
    MainTabView()
}
