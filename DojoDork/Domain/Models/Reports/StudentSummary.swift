//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

struct StudentSummary: Codable {
    let studentId: String
    let studentName: String
    let lastPromotionDate: String
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
