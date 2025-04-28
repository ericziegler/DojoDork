//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

let tokenCacheKey = "com.dojodork.tokenKey"
let userCacheKey = "com.dojodork.userKey"

final class UserRepository: UserRepositoryProtocol {
    
    private(set) var token: String? = nil
    private(set) var user: User? = nil
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService(),
        cacheService: CacheServiceProtocol = DependencyContainer.resolveCacheService()
    ) {
        self.networkService = networkService
        self.cacheService = cacheService
        loadToken()
        Task {
            try? await loadUser()
        }
    }
    
    func createUser(email: String, name: String) async throws -> Bool {
        let data = try await networkService.request(
            endpoint: "user/create.php",
            parameters: ["email": email, "name": name]
        )
        
        let response = try APIDecoder.decodeAPIResponse(EmptyModel.self, from: data)
        return response.isSuccess
    }
    
    func requestLoginCode(email: String) async throws -> Bool {
        let data = try await networkService.request(
            endpoint: "user/request_code.php",
            parameters: ["email": email]
        )
        
        let response = try APIDecoder.decodeAPIResponse(EmptyModel.self, from: data)
        return response.isSuccess
    }
    
    func validateLoginCode(email: String, code: String) async throws {
        let data = try await networkService.request(
            endpoint: "user/validate_code.php",
            parameters: ["email": email, "code": code]
        )
        
        // Expecting: { "token": "..." }
        let response = try APIDecoder.decodeAPIResponse(Token.self, from: data)
        guard let token = response.model?.token else {
            throw APIError.decodingFailed
        }
        
        saveToken(token)
    }
    
    // MARK: - Token
    
    func loadToken() {
        token = cacheService.loadString(for: tokenCacheKey)
    }
    
    private func saveToken(_ token: String) {
        cacheService.saveString(token, for: tokenCacheKey)
        self.token = token
    }
    
    private func clearToken() {
        cacheService.removeString(for: tokenCacheKey)
        token = nil
    }
    
    // MARK: - User
    
    func loadUser() async throws -> User {
        if let userData = cacheService.loadData(for: userCacheKey),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            return user
        } else {
            let data = try await networkService.request(endpoint: "user/info.php", credentials: ["token": token ?? ""])
            
            let response = try APIDecoder.decodeAPIResponse(User.self, from: data)
            guard let user = response.model else {
                throw APIError.decodingFailed
            }
            
            self.user = user
            saveUser()
            return user
        }
    }
    
    private func saveUser() {
        guard let user,
              let userData = try? JSONEncoder().encode(user) else {
            return
        }
        
        cacheService.save(data: userData, for: userCacheKey)
    }
    
    private func clearUser() {
        cacheService.removeData(for: userCacheKey)
        user = nil
    }
    
    func logout() {
        clearToken()
        clearUser()
    }
}
