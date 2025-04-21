//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@MainActor
final class AppState: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()) {
        self.userRepository = userRepository
        checkCredentials()
    }
    
    func checkCredentials() {
        isAuthenticated = userRepository.token != nil
    }
    
}
