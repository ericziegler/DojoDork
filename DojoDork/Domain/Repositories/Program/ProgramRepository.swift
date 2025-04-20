//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

final class ProgramRepository: ProgramRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = DependencyContainer.resolveNetworkService()) {
        self.networkService = networkService
    }
    
    func createProgram(name: String) async throws -> Program {
        let data = try await networkService.request(
            endpoint: "program/create.php",
            parameters: ["name": name]
        )
        return try JSONParser.parse(json: data)
    }
    
    func updateProgram(id: String, name: String) async throws {
        _ = try await networkService.request(
            endpoint: "program/update.php",
            parameters: [
                "program_id": id,
                "name": name
            ]
        )
    }
    
    func listPrograms() async throws -> Programs {
        let data = try await networkService.request(
            endpoint: "program/list.php"
        )
        return try JSONParser.parse(json: data, key: "programs")
    }
    
    func deleteProgram(id: String) async throws {
        let _ = try await networkService.request(
            endpoint: "program/delete.php",
            parameters: ["program_id": id]
        )
        // No need to decode anything; expect status: success
    }
}
