//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class RosterViewModel {
    
    private let studentRepository: StudentRepositoryProtocol
    private let attendanceRepository: AttendanceRepositoryProtocol
    
    var students: StudentSummaries = []
    var isLoading: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var sortOption: RosterSortOption = .nameAscending
    var searchText: String = ""

    init(
        studentRepository: StudentRepositoryProtocol = DependencyContainer.resolveStudentRepository(),
        attendanceRepository: AttendanceRepositoryProtocol = DependencyContainer.resolveAttendanceRepository()
    ) {
        self.studentRepository = studentRepository
        self.attendanceRepository = attendanceRepository
    }
    
    func loadStudents() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let basicStudents = try await studentRepository.listStudents()
            // TODO: EZ
            let summaries = StudentSummaries.mockData
//            var summaries: StudentSummaries = []
//            for student in basicStudents {
//                do {
//                    let summary = try await attendanceRepository.studentSummary(for: student.id)
//                    summaries.append(summary)
//                } catch {
//                    print("Failed to load summary for student id \(student.id): \(error.localizedDescription)")
//                }
//            }
            self.students = applySort(to: summaries)
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    func applySort(to students: StudentSummaries) -> StudentSummaries {
        switch sortOption {
        case .nameAscending:
            return students.sorted { $0.studentName.lowercased() < $1.studentName.lowercased() }
        case .nameDescending:
            return students.sorted { $0.studentName.lowercased() > $1.studentName.lowercased() }
        case .classCountDescending:
            return students.sorted { $0.classesSinceLastPromotion > $1.classesSinceLastPromotion }
        case .classCountAscending:
            return students.sorted { $0.classesSinceLastPromotion < $1.classesSinceLastPromotion }
        }
    }
    
    func sortStudents() {
        students = applySort(to: students)
    }
    
    var filteredStudents: StudentSummaries {
        guard !searchText.isEmpty else {
            return students
        }
        
        return students.filter { $0.studentName.localizedCaseInsensitiveContains(searchText) }
    }
}
