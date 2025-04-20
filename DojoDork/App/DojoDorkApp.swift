//
//  Created by Eric Ziegler on 4/19/25.
//

import SwiftUI

@main
struct DojoDorkApp: App {
    
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isAuthenticated {
                MainTabView()
            } else {
                RequestCodeView()
            }
        }
    }
}
