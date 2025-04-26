//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias StudentSummaries = [StudentSummary]

struct StudentSummary: Codable {
    let studentId: String
    let studentName: String
    let lastPromotionDate: String?
    let totalClassesAttended: Int
    let classesSinceLastPromotion: Int

    enum CodingKeys: String, CodingKey {
        case studentId = "student_id"
        case studentName = "student_name"
        case lastPromotionDate = "last_promotion_date"
        case totalClassesAttended = "total_classes_attended"
        case classesSinceLastPromotion = "classes_since_last_promotion"
    }
}

extension StudentSummary {
    static var mockData: StudentSummary {
        .init(
            studentId: "123",
            studentName: "Jane Doe",
            lastPromotionDate: "2024-12-05",
            totalClassesAttended: 87,
            classesSinceLastPromotion: 15
        )
    }
}

extension StudentSummaries {
    static var mockData: StudentSummaries {
        [
            .init(
                studentId: "123",
                studentName: "Jason",
                lastPromotionDate: "2024-12-05",
                totalClassesAttended: 100,
                classesSinceLastPromotion: 15
            ),
            .init(
                studentId: "234",
                studentName: "Trini",
                lastPromotionDate: "2024-12-05",
                totalClassesAttended: 90,
                classesSinceLastPromotion: 12
            ),
            .init(
                studentId: "345",
                studentName: "Billy",
                lastPromotionDate: "2025-01-19",
                totalClassesAttended: 100,
                classesSinceLastPromotion: 9
            ),
            .init(
                studentId: "456",
                studentName: "Kimberly",
                lastPromotionDate: nil,
                totalClassesAttended: 3,
                classesSinceLastPromotion: 5
            ),
            .init(
                studentId: "567",
                studentName: "Zack",
                lastPromotionDate: "2025-02-20",
                totalClassesAttended: 100,
                classesSinceLastPromotion: 11
            ),
            .init(
                studentId: "678",
                studentName: "Rocky",
                lastPromotionDate: "2024-12-05",
                totalClassesAttended: 100,
                classesSinceLastPromotion: 15
            ),
            .init(
                studentId: "789",
                studentName: "Adam",
                lastPromotionDate: "2024-12-05",
                totalClassesAttended: 90,
                classesSinceLastPromotion: 12
            ),
            .init(
                studentId: "901",
                studentName: "Aisha",
                lastPromotionDate: "2025-01-19",
                totalClassesAttended: 100,
                classesSinceLastPromotion: 9
            ),
            .init(
                studentId: "0012",
                studentName: "Katherine",
                lastPromotionDate: nil,
                totalClassesAttended: 3,
                classesSinceLastPromotion: 5
            )
        ]
    }
}
