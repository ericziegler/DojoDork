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

    func submitCode() async {
        guard code.count == 6 else {
            alertMessage = "Please enter your 6-digit code."
            showAlert = true
            return
        }

        isLoading = true
        do {
            try await userRepository.validateLoginCode(email: email, code: code)
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
        isLoading = false
    }
}
