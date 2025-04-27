//
// Created by Eric Ziegler on 4/27/25
//  

import SwiftUI

@Observable
@MainActor
final class AddStudentViewModel {
    
    var name: String = ""
    var isLoading = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    
    private let studentRepo: StudentRepositoryProtocol
    
    init(studentRepo: StudentRepositoryProtocol = DependencyContainer.resolveStudentRepository()) {
        self.studentRepo = studentRepo
    }
    
    func createStudent() async {
        isLoading = true
        do {
            _ = try await studentRepo.createStudent(name: name, promotionDate: nil)
        } catch {
            showAlert(message: "We were unable to create the student at this time.")
        }
        isLoading = false
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
