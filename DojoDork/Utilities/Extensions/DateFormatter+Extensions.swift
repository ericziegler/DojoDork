//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

extension DateFormatter {
 
    static var attendance: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
}
