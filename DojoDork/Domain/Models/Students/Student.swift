//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias Students = [Student]

struct Student: Codable, Identifiable {
    
    // MARK: - Properties
    
    let id: String
    let name: String
    let lastPromotionDate: Date? // format: yyyy-MM-dd
    var classCountTotal: Int = 0
    var classCountSincePromo: Int = 0
    
    var attendanceStatus: AttendanceStatus = .notAttended

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastPromotionDate = "last_promotion_date"
        case classCountTotal = "total_classes_attended"
        case classCountSincePromo = "classes_since_last_promotion"
    }
    
    // MARK: - Init
    
    init(
        id: String,
        name: String,
        lastPromotionDate: Date? = nil,
        classCountTotal: Int = 0,
        classCountSincePromo: Int = 0,
        attendanceStatus: AttendanceStatus = .notAttended
    ) {
        self.id = id
        self.name = name
        self.lastPromotionDate = lastPromotionDate
        self.classCountTotal = classCountTotal
        self.classCountSincePromo = classCountSincePromo
        self.attendanceStatus = attendanceStatus
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.lastPromotionDate = try container.decodeIfPresent(Date.self, forKey: .lastPromotionDate)
        self.classCountTotal = try container.decodeIfPresent(Int.self, forKey: .classCountTotal) ?? 0
        self.classCountSincePromo = try container.decodeIfPresent(Int.self, forKey: .classCountSincePromo) ?? 0
    }
}

extension Student {
    static var mockData: Student {
        Students.mockData.first!
    }
}

extension Students {
    static var mockData: Students {
        [
            .init(
                id: "012",
                name: "Tommy",
                lastPromotionDate: DateFormatter.attendance.date(from: "2025-02-05"),
                classCountTotal: 100,
                classCountSincePromo: 9
            ),
            .init(
                id: "234",
                name: "Trini",
                lastPromotionDate: DateFormatter.attendance.date(from: "2024-12-05"),
                classCountTotal: 90,
                classCountSincePromo: 12
            ),
            .init(
                id: "345",
                name: "Billy",
                lastPromotionDate: DateFormatter.attendance.date(from: "2025-01-19"),
                classCountTotal: 100,
                classCountSincePromo: 9
            ),
            .init(
                id: "456",
                name: "Kimberly",
                lastPromotionDate: nil,
                classCountTotal: 3,
                classCountSincePromo: 5
            ),
            .init(
                id: "567",
                name: "Zack",
                lastPromotionDate: DateFormatter.attendance.date(from: "2025-02-20"),
                classCountTotal: 100,
                classCountSincePromo: 11
            ),
            .init(
                id: "678",
                name: "Rocky",
                lastPromotionDate: DateFormatter.attendance.date(from: "2024-12-05"),
                classCountTotal: 100,
                classCountSincePromo: 15
            ),
            .init(
                id: "789",
                name: "Adam",
                lastPromotionDate: DateFormatter.attendance.date(from: "2024-12-05"),
                classCountTotal: 90,
                classCountSincePromo: 12
            ),
            .init(
                id: "901",
                name: "Aisha",
                lastPromotionDate: DateFormatter.attendance.date(from: "2025-01-19"),
                classCountTotal: 100,
                classCountSincePromo: 9
            ),
            .init(
                id: "0012",
                name: "Katherine",
                lastPromotionDate: nil,
                classCountTotal: 3,
                classCountSincePromo: 5
            )
        ]
    }
}
