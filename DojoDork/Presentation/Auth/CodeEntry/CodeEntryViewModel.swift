//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class CodeEntryViewModel {
    
    private let userRepository: UserRepositoryProtocol
    
    let email: String
    
    // UI State
    var code: String = ""
    var isLoading: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""

    init(
        email: String,
        userRepository: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()
    ) {
        self.email = email
        self.userRepository = userRepository
    }

    func submitCode() async -> Bool {
        guard code.count == 6 else {
            alertMessage = "Please enter your 6-digit code."
            showAlert = true
            return false
        }

        isLoading = true
        do {
            try await userRepository.validateLoginCode(email: email, code: code)
            isLoading = false
            return true
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
            isLoading = false
            return false
        }
    }
}
