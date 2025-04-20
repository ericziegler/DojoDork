//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

struct User: Codable {
    let email: String
    let name: String
    let organizationId: String

    enum CodingKeys: String, CodingKey {
        case email
        case name
        case organizationId = "organization_id"
    }
}

extension User {
    
    static var mockData: User {
        .init(
            email: "testuser@dojovista.com",
            name: "Test User",
            organizationId: "mock-organization-id"
        )
    }
    
}
