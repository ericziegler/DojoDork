//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class AppState {
    
    var isAuthenticated: Bool = false
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()) {
        self.userRepository = userRepository
        checkCredentials()
    }
    
    private func checkCredentials() {
        isAuthenticated = userRepository.token != nil
    }
    
}
