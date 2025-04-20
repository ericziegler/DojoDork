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
            alertMessage = "Please enter your email address."
            showAlert = true
            return
        }

        isLoading = true
        do {
            try await userRepository.requestLoginCode(email: email)
            navigateToCodeEntry = true
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
        isLoading = false
    }
}
