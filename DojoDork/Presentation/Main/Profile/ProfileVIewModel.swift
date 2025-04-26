//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class ProfileViewModel {
    
    // MARK: - Properties
    
    private let userRepo: UserRepositoryProtocol
    
    var username: String = "TEST USER"
    
    // MARK: - Init
    
    init(userRepo: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()) {
        self.userRepo = userRepo
    }
    
    // MARK: - User
    
    func logout() {
        // TODO: EZ - Logout
    }
    
}
