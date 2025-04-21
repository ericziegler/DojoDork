//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class ProgramRepository: ProgramRepositoryProtocol {
    
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
    
    func createProgram(name: String) async throws -> Program {
        let data = try await networkService.request(
            endpoint: "program/create.php",
            parameters: ["name": name],
            credentials: tokenParam
        )
        return try JSONParser.parse(json: data)
    }
    
    func updateProgram(id: String, name: String) async throws {
        _ = try await networkService.request(
            endpoint: "program/update.php",
            parameters: [
                "program_id": id,
                "name": name
            ],
            credentials: tokenParam
        )
    }
    
    func listPrograms() async throws -> Programs {
        let data = try await networkService.request(
            endpoint: "program/list.php",
            credentials: tokenParam
        )
        return try JSONParser.parse(json: data, key: "programs")
    }
    
    func deleteProgram(id: String) async throws {
        let _ = try await networkService.request(
            endpoint: "program/delete.php",
            parameters: ["program_id": id],
            credentials: tokenParam
        )
        // No need to decode anything; expect status: success
    }
}
