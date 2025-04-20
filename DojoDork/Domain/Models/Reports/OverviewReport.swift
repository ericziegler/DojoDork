//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

struct OverviewReport: Codable {
    let totalActiveStudents: Int
    let totalAttendanceLogs: Int
    let attendanceLast30Days: Int

    enum CodingKeys: String, CodingKey {
        case totalActiveStudents = "total_active_students"
        case totalAttendanceLogs = "total_attendance_logs"
        case attendanceLast30Days = "attendance_last_30_days"
    }
}
