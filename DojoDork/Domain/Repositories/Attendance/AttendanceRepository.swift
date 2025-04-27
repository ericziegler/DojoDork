//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class AttendanceRepository: AttendanceRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    var tokenParam: [String: String]? {
        guard let token = cacheService.loadString(for: tokenCacheKey) else { return nil }
        return ["token": token]
    }

    init(
        networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService(),
        cacheService: CacheServiceProtocol = DependencyContainer.resolveCacheService()
    ) {
        self.networkService = networkService
        self.cacheService = cacheService
    }

    func toggleAttendance(for studentId: String, on date: String, didAttend: Bool) async throws {
        _ = try await networkService.request(
            endpoint: "attendance/toggle.php",
            parameters: [
                "student_id": studentId,
                "date": date,
                "didAttend": didAttend ? "1" : "0"
            ],
            credentials: tokenParam
        )
    }
    
    func attendanceLogs(for studentId: String) async throws -> AttendanceLogs {
        let data = try await networkService.request(
            endpoint: "attendance/by_student.php",
            parameters: ["student_id": studentId],
            credentials: tokenParam
        )
        return try JSONParser.parse(json: data, key: "attendance")
    }

    func studentsAttended(on date: String) async throws -> Students {
        let data = try await networkService.request(
            endpoint: "attendance/by_date.php",
            parameters: ["date": date],
            credentials: tokenParam
        )
        return try JSONParser.parse(json: data, key: "students")
    }
}
