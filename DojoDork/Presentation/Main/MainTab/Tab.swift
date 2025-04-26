//
// Created by Eric Ziegler on 4/25/25
//  

import Foundation

enum Tab: Int, Hashable {
    case attendance
    case roster
    
    var text: String {
        switch self {
        case .attendance:
            return "Attendance"
        case .roster:
            return "Roster"
        }
    }
    
    var imageName: String {
        switch self {
        case .attendance:
            return "person.fill.checkmark"
        case .roster:
            return "list.clipboard.fill"
        }
    }
}
