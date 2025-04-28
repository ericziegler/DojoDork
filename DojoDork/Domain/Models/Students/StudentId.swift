//
// Created by Eric Ziegler on 4/27/25
//  

import Foundation

struct StudentId: Codable {
    let studentId: String
    
    enum CodingKeys: String, CodingKey {
        case studentId = "student_id"
    }
}
