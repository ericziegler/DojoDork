//
// Created by Eric Ziegler on 4/27/25
//  

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: String?
    let error: String?
    let model: T?

    var isSuccess: Bool {
        return status == "success"
    }
}
