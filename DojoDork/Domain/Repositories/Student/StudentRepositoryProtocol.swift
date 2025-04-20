//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol StudentRepositoryProtocol {
    func createStudent(name: String, promotionDate: String?) async throws -> Student
    func updateStudent(id: String, name: String?, promotionDate: String?) async throws
    func listStudents() async throws -> Students
    func deleteStudent(id: String) async throws
}
