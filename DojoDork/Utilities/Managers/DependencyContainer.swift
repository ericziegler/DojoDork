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

    static func resolveAttendanceRepository() -> AttendanceRepositoryProtocol {
        return self.shared.resolve(AttendanceRepositoryProtocol.self)!
    }
    
    static func resolveStudentRepository() -> StudentRepositoryProtocol {
        return self.shared.resolve(StudentRepositoryProtocol.self)!
    }
    
    static func resolveUserRepository() -> UserRepositoryProtocol {
        return self.shared.resolve(UserRepositoryProtocol.self)!
    }

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
        
        container.register(AttendanceRepositoryProtocol.self) { r in
            let cacheService = r.resolve(CacheServiceProtocol.self)!
            let networkService = r.resolve(NetworkServiceProtocol.self)!
            return AttendanceRepository(networkService: networkService)
        }.inObjectScope(.container)
        
        container.register(StudentRepositoryProtocol.self) { r in
            let cacheService = r.resolve(CacheServiceProtocol.self)!
            let networkService = r.resolve(NetworkServiceProtocol.self)!
            return StudentRepository(networkService: networkService)
        }.inObjectScope(.container)
        
        container.register(UserRepositoryProtocol.self) { r in
            let cacheService = r.resolve(CacheServiceProtocol.self)!
            let networkService = r.resolve(NetworkServiceProtocol.self)!
            return UserRepository(networkService: networkService)
        }.inObjectScope(.container)
        
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
