//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias Students = [Student]

struct Student: Codable, Identifiable {
    let id: String
    let name: String
    let lastPromotionDate: String? // format: yyyy-MM-dd

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

extension Students {
    static var mockData: Students {
        [
            .init(
                id: "123",
                name: "Jason",
                lastPromotionDate: "2024-12-05"
            ),
            .init(
                id: "234",
                name: "Trini",
                lastPromotionDate: "2024-12-05"
            ),
            .init(
                id: "345",
                name: "Billy",
                lastPromotionDate: "2025-01-19"
            ),
            .init(
                id: "456",
                name: "Kimberly",
                lastPromotionDate: nil
            ),
            .init(
                id: "567",
                name: "Zack",
                lastPromotionDate: "2025-02-20"
            ),
        ]
    }
}
