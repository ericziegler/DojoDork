//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class AttendanceRepository: AttendanceRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService()) {
        self.networkService = networkService
    }

    func markAttendance(for studentId: String, on date: String) async throws {
        _ = try await networkService.request(
            endpoint: "attendance/mark.php",
            parameters: ["student_id": studentId, "date": date]
        )
    }
    
    func attendanceLogs(for studentId: String) async throws -> AttendanceLogs {
        let data = try await networkService.request(
            endpoint: "attendance/by_student.php",
            parameters: ["student_id": studentId]
        )
        return try JSONParser.parse(json: data, key: "attendance")
    }

    func studentsAttended(on date: String) async throws -> Students {
        let data = try await networkService.request(
            endpoint: "attendance/by_date.php",
            parameters: ["date": date]
        )
        return try JSONParser.parse(json: data, key: "students")
    }

    func studentSummary(for studentId: String) async throws -> StudentSummary {
        let data = try await networkService.request(
            endpoint: "report/student_summary.php",
            parameters: ["student_id": studentId]
        )
        return try JSONParser.parse(json: data)
    }
}
