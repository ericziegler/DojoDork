//
// Created by Eric Ziegler on 4/19/25
//  

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
