//
// Created by Eric Ziegler on 4/25/25
//  

import Foundation

enum Tab: Int, Hashable {
    case attendance
    case roster
    case profile
    
    var text: String {
        switch self {
        case .attendance:
            return "Attendance"
        case .roster:
            return "Roster"
        case .profile:
            return "Profile"
        }
    }
    
    var imageName: String {
        switch self {
        case .attendance:
            return "checkmark.circle.fill"
        case .roster:
            return "list.clipboard.fill"
        case .profile:
            return "person.fill"
        }
    }
}
