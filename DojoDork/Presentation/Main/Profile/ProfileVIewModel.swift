//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class ProfileViewModel {
    
    // MARK: - Properties
    
    private let userRepo: UserRepositoryProtocol
    
    var username: String = " "
    
    // MARK: - Init
    
    init(userRepo: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()) {
        self.userRepo = userRepo
        Task {
            await self.loadUserInfo()
        }
    }
    
    // MARK: - User
    
    private func loadUserInfo() async {
        do {
            let user = try await userRepo.loadUser()
            username = user.name
        } catch {
            print(error)
        }
    }
    
    func logout() {
        userRepo.logout()
    }
    
}
