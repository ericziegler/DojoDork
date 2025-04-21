//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class RequestCodeViewModel {

    // MARK: - Properties
    
    private let userRepository: UserRepositoryProtocol

    var email: String = ""
    var isLoading: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var navigateToCodeEntry: Bool = false

    init(
        userRepository: UserRepositoryProtocol = DependencyContainer.resolveUserRepository()
    ) {
        self.userRepository = userRepository
    }

    func submitEmail() async {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(message: "Please enter your email address.")
            return
        }

        isLoading = true
        do {
            let success = try await userRepository.requestLoginCode(email: email)
            if success {
                navigateToCodeEntry = true
            } else {
                showAlert(message: "Unable to send request code. Please make sure you have an account.")
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
        isLoading = false
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
