//
// Created by Eric Ziegler on 4/20/25
//  

import SwiftUI

@Observable
@MainActor
final class AttendanceViewModel {
 
    private let attendanceRepository: AttendanceRepositoryProtocol
    private let studentRepository: StudentRepositoryProtocol
    
    var classDate: Date = Date()
    var students: Students = []
    var isLoading: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var sortOption: RosterSortOption = .nameAscending
    var searchText: String = ""
    
    var formattedDate: String {
        DateFormatter.header.string(from: classDate)
    }

    init(
        attendanceRepository: AttendanceRepositoryProtocol = DependencyContainer.resolveAttendanceRepository(),
        studentRepository: StudentRepositoryProtocol = DependencyContainer.resolveStudentRepository()
    ) {
        self.attendanceRepository = attendanceRepository
        self.studentRepository = studentRepository
    }
    
    func loadStudents() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            // Fetch all students
            let allStudents = try await studentRepository.listStudents()
            
            // Fetch students who attended the selected date
            let attendedStudents = try await attendanceRepository.studentsAttended(
                on: DateFormatter.attendance.string(from: classDate)
            )
            
            // Build a Set for fast lookup
            let attendedIds = Set(attendedStudents.map { $0.id })
            
            // Update each student with their attendance status
            let updatedStudents = allStudents.map { student in
                var updatedStudent = student
                if attendedIds.contains(student.id) {
                    updatedStudent.attendanceStatus = .attended
                } else {
                    updatedStudent.attendanceStatus = .notAttended
                }
                return updatedStudent
            }
            
            // Apply sort and assign
            self.students = applySort(to: updatedStudents)
            
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
    
    func toggleAttendance(for studentId: String) async {
        guard let index = students.firstIndex(where: { $0.id == studentId }),
              students[index].attendanceStatus != .updating else {
            return
        }

        let student = students[index]
        let isCurrentlyAttended = (student.attendanceStatus == .attended)
        students[index].attendanceStatus = .updating

        do {
            let newAttendStatus = !isCurrentlyAttended
            try await attendanceRepository.toggleAttendance(
                for: student.id,
                on: DateFormatter.attendance.string(from: classDate),
                didAttend: newAttendStatus
            )

            students[index].attendanceStatus = newAttendStatus ? .attended : .notAttended
        } catch {
            showAlert(message: error.localizedDescription)
            // Fallback to previous state if desired
            students[index].attendanceStatus = .notAttended
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
}
