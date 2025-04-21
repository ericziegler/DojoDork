//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class CreateAccountViewModel {
    
    private let userRepository: UserRepositoryProtocol

    // MARK: - UI State
    var name: String = ""
    var email: String = ""
    var isLoading: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var navigateToCodeEntry: Bool = false

    init(userRepository: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()) {
        self.userRepository = userRepository
    }

    func submit() async {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter your name."
            showAlert = true
            return
        }

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter your email."
            showAlert = true
            return
        }

        isLoading = true
        do {
            _ = try await userRepository.createUser(email: email, name: name)
            navigateToCodeEntry = true
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
        isLoading = false
    }
}
