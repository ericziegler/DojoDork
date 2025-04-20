//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol AttendanceRepositoryProtocol {
    func toggleAttendance(for studentId: String, on date: String, didAttend: Bool) async throws
    func attendanceLogs(for studentId: String) async throws -> AttendanceLogs
    func studentsAttended(on date: String) async throws -> Students
    func studentSummary(for studentId: String) async throws -> StudentSummary
}
