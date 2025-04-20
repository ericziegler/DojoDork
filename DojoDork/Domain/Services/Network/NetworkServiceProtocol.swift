//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol NetworkServiceProtocol {
    var baseURL: String { get }
    var credentials: Credentials? { get }
    @discardableResult func request(endpoint: String,
                                    method: HTTPMethod,
                                    parameters: Parameters?,
                                    includeCredentials: Bool,
                                    ignoreCache: Bool,
                                    timeoutInterval: Double) async throws -> Data?
    func loadCredentials()
    func setCredentials(_ creds: Credentials)
    func clearCredentials()
}

// default implementation
extension NetworkServiceProtocol {
    @discardableResult func request(endpoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    includeCredentials: Bool = true,
                                    ignoreCache: Bool = true,
                                    timeoutInterval: Double = 20) async throws -> Data? {
        try await request(endpoint: endpoint,
                          method: method,
                          parameters: parameters,
                          includeCredentials: includeCredentials,
                          ignoreCache: ignoreCache,
                          timeoutInterval: timeoutInterval)
    }
}
