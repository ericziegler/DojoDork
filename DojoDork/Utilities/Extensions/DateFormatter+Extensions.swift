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
    
    static var display: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        return dateFormatter
    }
    
    static var header: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE. MMM d, yyyy"
        return dateFormatter
    }
    
}
