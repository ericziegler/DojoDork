//
// Created by Eric Ziegler on 4/26/25
//  

import SwiftUI

@Observable
@MainActor
final class StudentViewModel {
    private let originalStudent: Student
    
    var name: String
    var lastPromoted: Date?
    var classesSincePromotion: Int
    var totalClasses: Int
    
    init(student: Student) {
        self.originalStudent = student
        self.name = student.name
        self.lastPromoted = student.lastPromotionDate
        self.classesSincePromotion = student.classCountSincePromo
        self.totalClasses = student.classCountTotal
    }
    
    var lastPromotedString: String {
        guard let lastPromoted else { return "N/A" }
        return DateFormatter.display.string(from: lastPromoted)
    }
    
    func promoteStudent() {
        lastPromoted = Date()
        classesSincePromotion = 0
    }
    
    func deleteStudent() {
        // TODO: Handle deleting student
    }
    
    func saveChanges() {
        // TODO: Handle saving updated student
    }
    
    func resetChanges() {
        name = originalStudent.name
        lastPromoted = originalStudent.lastPromotionDate
        classesSincePromotion = originalStudent.classCountSincePromo
        totalClasses = originalStudent.classCountTotal
    }
}
