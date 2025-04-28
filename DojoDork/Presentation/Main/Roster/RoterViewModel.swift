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
            let fetchedStudents = try await studentRepository.listStudents()
            self.students = applySort(to: fetchedStudents)
        } catch {
            showAlert(message: error.localizedDescription)
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
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
