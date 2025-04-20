//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias Students = [Student]

struct Student: Codable, Identifiable {
    let id: String
    let name: String
    let lastPromotionDate: String // format: yyyy-MM-dd

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastPromotionDate = "last_promotion_date"
    }
}

extension Student {
 
    static var mockData: Student {
        .init(
            id: "mock-student-id",
            name: "Test Student",
            lastPromotionDate: "2025-02-14"
        )
    }
    
}
