//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias Programs = [Program]

struct Program: Codable, Identifiable {
    let id: String
    let name: String
    let organizationId: String
}

extension Program {
 
    static var mockData: Program {
        .init(
            id: "mock-program-id",
            name: "Test Program",
            organizationId: "mock-organization-id"
        )
    }
    
}
