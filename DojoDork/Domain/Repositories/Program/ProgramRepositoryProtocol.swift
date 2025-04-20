//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol ProgramRepositoryProtocol {
    func createProgram(name: String) async throws -> Program
    func updateProgram(id: String, name: String) async throws
    func listPrograms() async throws -> Programs
    func deleteProgram(id: String) async throws
}
