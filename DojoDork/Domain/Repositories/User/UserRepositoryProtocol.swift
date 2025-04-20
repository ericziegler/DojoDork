//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol UserRepositoryProtocol {
    func createUser(email: String, name: String) async throws -> User
    func validateLoginCode(email: String, code: String) async throws -> String
    func fetchUserInfo() async throws -> User
}
