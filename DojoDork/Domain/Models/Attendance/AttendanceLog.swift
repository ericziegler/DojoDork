//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias AttendanceLogs = [AttendanceLog]

struct AttendanceLog: Codable {
    let date: Date // format: yyyy-MM-dd
}
