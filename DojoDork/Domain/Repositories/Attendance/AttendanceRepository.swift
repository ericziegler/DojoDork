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
        let data = try await networkService.request(
            endpoint: "attendance/toggle.php",
            parameters: [
                "student_id": studentId,
                "date": date,
                "didAttend": didAttend ? "1" : "0"
            ],
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(EmptyModel.self, from: data)
        guard response.isSuccess else {
            throw APIError.decodingFailed
        }
    }
    
    func attendanceLogs(for studentId: String) async throws -> AttendanceLogs {
        let data = try await networkService.request(
            endpoint: "attendance/by_student.php",
            parameters: ["student_id": studentId],
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(AttendanceLogs.self, from: data)
        guard let logs = response.model else {
            throw APIError.decodingFailed
        }
        return logs
    }

    func studentsAttended(on date: String) async throws -> Students {
        let data = try await networkService.request(
            endpoint: "attendance/by_date.php",
            parameters: ["date": date],
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(Students.self, from: data)
        guard let students = response.model else {
            throw APIError.decodingFailed
        }
        return students
    }
}
