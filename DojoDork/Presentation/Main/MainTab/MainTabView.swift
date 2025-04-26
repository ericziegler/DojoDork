//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var appState: AppState
    
    @State private var selectedTab = 0
    @State private var isShowingProfile = false
    @State private var settingsDetent = PresentationDetent.height(375)
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                renderTab(
                    view: AttendanceView(showProfile: $isShowingProfile),
                    tab: .attendance
                )
                renderTab(
                    view: RosterView(showProfile: $isShowingProfile),
                    tab: .roster
                )
            }
            .toolbarBackground(Color.appBar, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(.brand)
        .sheet(isPresented: $isShowingProfile, content: {
            renderProfileView()
                .presentationDetents(
                    [.height(375)],
                    selection: $settingsDetent
                 )
        })
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
    
    @ViewBuilder private func renderProfileView() -> some View {
        ProfileView {
            isShowingProfile = false
            appState.checkCredentials()
        }
    }
    
    private func showProfile() {
        isShowingProfile.toggle()
    }
}

#Preview {
    MainTabView()
}
