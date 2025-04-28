//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class StudentRepository: StudentRepositoryProtocol {
    
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
    
    func createStudent(name: String) async throws -> String {
        let params: Parameters = ["name": name]
        
        let data = try await networkService.request(
            endpoint: "student/create.php",
            parameters: params,
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(StudentId.self, from: data)
        guard let studentId = response.model?.studentId else { throw APIError.decodingFailed }
        
        return studentId
    }
    
    func updateStudent(id: String, name: String?, promotionDate: String?) async throws {
        var params: Parameters = ["student_id": id]
        if let name = name {
            params["name"] = name
        }
        if let promotionDate = promotionDate {
            params["last_promotion_date"] = promotionDate
        }
                
        let data = try await networkService.request(
            endpoint: "student/update.php",
            parameters: params,
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(EmptyModel.self, from: data)
        guard response.isSuccess else { throw APIError.decodingFailed }
    }
    
    func listStudents() async throws -> Students {
        let data = try await networkService.request(
            endpoint: "student/list.php",
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(Students.self, from: data)
        guard let students = response.model else { throw APIError.decodingFailed }
        return students
    }
    
    func deleteStudent(id: String) async throws {
        let data = try await networkService.request(
            endpoint: "student/delete.php",
            parameters: ["student_id": id],
            credentials: tokenParam
        )
        
        let response = try APIDecoder.decodeAPIResponse(EmptyModel.self, from: data)
        if !response.isSuccess {
            throw APIError.decodingFailed
        }
    }
}
