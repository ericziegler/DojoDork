//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class UserRepository: UserRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService()) {
        self.networkService = networkService
    }
    
    func createUser(email: String, name: String) async throws -> User {
        let data = try await networkService.request(
            endpoint: "user/create.php",
            parameters: ["email": email, "name": name],
            includeCredentials: false
        )
        return try JSONParser.parse(json: data)
    }
    
    func validateLoginCode(email: String, code: String) async throws -> String {
        let data = try await networkService.request(
            endpoint: "user/validate_code.php",
            parameters: ["email": email, "code": code],
            includeCredentials: false
        )
        // Expecting: { status: "success", token: "..." }
        let response = try JSONSerialization.jsonObject(with: data ?? Data()) as? [String: Any]
        guard let token = response?["token"] as? String else {
            throw APIError.decodingFailed
        }
        return token
    }
    
    func fetchUserInfo() async throws -> User {
        let data = try await networkService.request(endpoint: "user/info.php")
        return try JSONParser.parse(json: data)
    }
}
