//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol UserRepositoryProtocol {
    var token: String? { get }
    func createUser(email: String, name: String) async throws -> Bool
    func requestLoginCode(email: String) async throws -> Bool
    func validateLoginCode(email: String, code: String) async throws
    func fetchUserInfo() async throws -> User
}
