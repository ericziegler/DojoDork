//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class StudentRepository: StudentRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService()) {
        self.networkService = networkService
    }
    
    func createStudent(name: String, promotionDate: String?) async throws -> Student {
        var params: Parameters = ["name": name]
        if let promotionDate = promotionDate {
            params["last_promotion_date"] = promotionDate
        }
        
        let data = try await networkService.request(
            endpoint: "student/create.php",
            parameters: params
        )
        return try JSONParser.parse(json: data)
    }
    
    func updateStudent(id: String, name: String?, promotionDate: String?) async throws {
        var params: Parameters = ["student_id": id]
        if let name = name {
            params["name"] = name
        }
        if let promotionDate = promotionDate {
            params["last_promotion_date"] = promotionDate
        }
        
        _ = try await networkService.request(
            endpoint: "student/update.php",
            parameters: params
        )
    }
    
    func listStudents() async throws -> Students {
        let data = try await networkService.request(
            endpoint: "student/list.php"
        )
        return try JSONParser.parse(json: data, key: "students")
    }
    
    func deleteStudent(id: String) async throws {
        _ = try await networkService.request(
            endpoint: "student/delete.php",
            parameters: ["student_id": id]
        )
    }
}
