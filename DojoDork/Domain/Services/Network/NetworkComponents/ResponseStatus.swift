//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

class ResponseStatus: Codable {
    let status: String
    
    var isSuccessful: Bool {
        return status.lowercased() == "success"
    }
}
