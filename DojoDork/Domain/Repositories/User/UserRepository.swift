//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

let tokenCacheKey = "com.dojodork.tokenKey"

final class UserRepository: UserRepositoryProtocol {
    
    private(set) var token: String? = nil
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService(),
        cacheService: CacheServiceProtocol = DependencyContainer.resolveCacheService()
    ) {
        self.networkService = networkService
        self.cacheService = cacheService
        loadToken()
    }
    
    func createUser(email: String, name: String) async throws -> User {
        let data = try await networkService.request(
            endpoint: "user/create.php",
            parameters: ["email": email, "name": name]
        )
        return try JSONParser.parse(json: data, key: "user")
    }
    
    func requestLoginCode(email: String) async throws {
        let data = try await networkService.request(
            endpoint: "user/send_verification.php",
            parameters: ["email": email]
        )
        
        // Parse status or throw
        let _: ResponseStatus = try JSONParser.parse(json: data)
    }
    
    func validateLoginCode(email: String, code: String) async throws {
        let data = try await networkService.request(
            endpoint: "user/validate_code.php",
            parameters: ["email": email, "code": code]
        )
        // Expecting: { status: "success", token: "..." }
        let response = try JSONSerialization.jsonObject(with: data ?? Data()) as? [String: Any]
        guard let token = response?["token"] as? String else {
            throw APIError.decodingFailed
        }
        
        setToken(token)
    }
    
    func fetchUserInfo() async throws -> User {
        let data = try await networkService.request(endpoint: "user/info.php")
        return try JSONParser.parse(json: data)
    }
    
    // MARK: - Token
    
    func loadToken() {
        token = cacheService.loadString(for: tokenCacheKey)
    }
    
    func setToken(_ token: String) {
        cacheService.saveString(token, for: tokenCacheKey)
        self.token = token
    }
    
    func clearToken() {
        cacheService.removeString(for: tokenCacheKey)
        self.token = nil
    }
}
