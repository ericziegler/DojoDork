//
// Created by Eric Ziegler on 4/26/25
//  

import SwiftUI

@Observable
@MainActor
final class StudentViewModel {
    private let originalStudent: Student
    
    private(set) var studentId = ""
    var name: String
    var lastPromoted: Date?
    var classesSincePromotion: Int
    var totalClasses: Int
    var isLoading = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    
    private let studentRepo: StudentRepositoryProtocol
    
    init(
        student: Student,
        studentRepo: StudentRepositoryProtocol = DependencyContainer.resolveStudentRepository()
    ) {
        self.studentId = student.id
        self.originalStudent = student
        self.studentRepo = studentRepo
        self.name = student.name
        self.lastPromoted = student.lastPromotionDate
        self.classesSincePromotion = student.classCountSincePromo
        self.totalClasses = student.classCountTotal
    }
    
    var lastPromotedString: String {
        guard let lastPromoted else { return "N/A" }
        return DateFormatter.display.string(from: lastPromoted)
    }
    
    func promoteStudent(date: Date) async {
        isLoading = true
        do {
            let newPromoDate = DateFormatter.attendance.string(from: date)
            try await studentRepo.updateStudent(id: originalStudent.id, name: nil, promotionDate: newPromoDate)
        } catch {
            showAlert(message: "We were unable to promote the student at this time.")
        }
        lastPromoted = date
        classesSincePromotion = 0
    }
    
    func deleteStudent() async {
        isLoading = true
        do {
            try await studentRepo.deleteStudent(id: originalStudent.id)
        } catch {
            showAlert(message: "We were unable to remove the student at this time.")
        }
        isLoading = false
    }
    
    func saveChanges() async {
        isLoading = true
        do {
            try await studentRepo.updateStudent(
                id: originalStudent.id,
                name: name,
                promotionDate: nil
            )
        } catch {
            showAlert(message: "We were unable to update the student at this time.")
        }
        isLoading = false
    }
    
    func resetChanges() {
        name = originalStudent.name
        lastPromoted = originalStudent.lastPromotionDate
        classesSincePromotion = originalStudent.classCountSincePromo
        totalClasses = originalStudent.classCountTotal
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
