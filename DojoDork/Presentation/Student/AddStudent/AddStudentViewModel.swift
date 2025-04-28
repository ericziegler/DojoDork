//
// Created by Eric Ziegler on 4/27/25
//  

import SwiftUI

@Observable
@MainActor
final class AddStudentViewModel {
    
    var name: String = ""
    private(set) var studentId = ""
    var isLoading = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    
    private let studentRepo: StudentRepositoryProtocol
    
    init(studentRepo: StudentRepositoryProtocol = DependencyContainer.resolveStudentRepository()) {
        self.studentRepo = studentRepo
    }
    
    func createStudent() async throws {
        isLoading = true
        studentId = try await studentRepo.createStudent(name: name)
        isLoading = false
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
