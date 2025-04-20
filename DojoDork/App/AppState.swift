//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class AppState {
    
    var isAuthenticated: Bool = false
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService()) {
        self.networkService = networkService
        checkCredentials()
    }
    
    private func checkCredentials() {
        isAuthenticated = networkService.credentials != nil
    }
    
}
