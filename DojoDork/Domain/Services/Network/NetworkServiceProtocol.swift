//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol NetworkServiceProtocol {
    var baseURL: String { get }
    @discardableResult func request(endpoint: String,
                                    method: HTTPMethod,
                                    parameters: Parameters?,
                                    credentials: [String: String]?,
                                    ignoreCache: Bool,
                                    timeoutInterval: Double) async throws -> Data?
}

// default implementation
extension NetworkServiceProtocol {
    @discardableResult func request(endpoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    credentials: [String: String]? = nil,
                                    ignoreCache: Bool = true,
                                    timeoutInterval: Double = 20) async throws -> Data? {
        try await request(endpoint: endpoint,
                          method: method,
                          parameters: parameters,
                          credentials: credentials,
                          ignoreCache: ignoreCache,
                          timeoutInterval: timeoutInterval)
    }
}
