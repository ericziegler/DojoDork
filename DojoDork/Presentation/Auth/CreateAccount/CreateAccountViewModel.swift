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
            showAlert(message: "Please enter your name.")
            return
        }

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }

        isLoading = true
        do {
            let success = try await userRepository.createUser(email: email, name: name)
            if success {
                await requestLoginCode()
            } else {
                showAlert(message: "We were unable to create a user with this email address.")
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    private func requestLoginCode() async {
        do {
            let success = try await userRepository.requestLoginCode(email: email)
            if success {
                navigateToCodeEntry = true
            } else {
                showAlert(message: "We were unable to create a user with this email address.")
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
