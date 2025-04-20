//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias AttendanceLogs = [AttendanceLog]

struct AttendanceLog: Codable {
    let date: String // format: yyyy-MM-dd
}
