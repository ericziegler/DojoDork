//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol UserRepositoryProtocol {
    var token: String? { get }
    func createUser(email: String, name: String) async throws -> User
    func requestLoginCode(email: String) async throws
    func validateLoginCode(email: String, code: String) async throws
    func fetchUserInfo() async throws -> User
}
