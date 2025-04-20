//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation
import Swinject

enum TargetType: String {
    case app = "AppCache"
    case unitTest = "TestCache"
    
    var isUnitTesting: Bool {
        switch self {
            case .app:
                return false
            case .unitTest:
                return true
        }
    }
}

struct DependencyContainer {
    
    // MARK: Repository Resolves

    // TODO: EZ

    // MARK: Services Resolves
    
    static func resolveCacheService() -> CacheServiceProtocol {
        return self.shared.resolve(CacheServiceProtocol.self)!
    }
    
    static func resolveNetworkService() -> NetworkServiceProtocol {
        return self.shared.resolve(NetworkServiceProtocol.self)!
    }
}

extension DependencyContainer {
    private static let shared: Container = {
        let container = Container()
        
        // MARK: - Repositories
        
        // TODO: EZ
        
        // MARK: - Services
        
        container.register(CacheServiceProtocol.self) { r in
            return CacheService()
        }.inObjectScope(.container)
        
        container.register(NetworkServiceProtocol.self) { r in
            return NetworkService(baseURL: APIURL)
        }.inObjectScope(.container)

        return container
    }()
}
