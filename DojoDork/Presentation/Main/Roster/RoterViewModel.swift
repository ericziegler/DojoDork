//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class RosterViewModel {
    
    private let studentRepository: StudentRepositoryProtocol
    
    var students: Students = []
    var isLoading: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var sortOption: RosterSortOption = .nameAscending
    var searchText: String = ""

    init(
        studentRepository: StudentRepositoryProtocol = DependencyContainer.resolveStudentRepository()
    ) {
        self.studentRepository = studentRepository
    }
    
    func loadStudents() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let basicStudents = try await studentRepository.listStudents()
            // TODO: EZ
            let fetchedStudents = Students.mockData
//            var summaries: StudentSummaries = []
//            for student in basicStudents {
//                do {
//                    let summary = try await attendanceRepository.studentSummary(for: student.id)
//                    summaries.append(summary)
//                } catch {
//                    print("Failed to load summary for student id \(student.id): \(error.localizedDescription)")
//                }
//            }
            self.students = applySort(to: fetchedStudents)
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    func applySort(to students: Students) -> Students {
        switch sortOption {
        case .nameAscending:
            return students.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .nameDescending:
            return students.sorted { $0.name.lowercased() > $1.name.lowercased() }
        case .classCountDescending:
            return students.sorted { $0.classCountSincePromo > $1.classCountSincePromo }
        case .classCountAscending:
            return students.sorted { $0.classCountSincePromo < $1.classCountSincePromo }
        }
    }
    
    func sortStudents() {
        students = applySort(to: students)
    }
    
    var filteredStudents: Students {
        guard !searchText.isEmpty else {
            return students
        }
        
        return students.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
