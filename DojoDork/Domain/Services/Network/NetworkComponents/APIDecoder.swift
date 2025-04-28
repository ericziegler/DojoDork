//
// Created by Eric Ziegler on 4/27/25
//  

import Foundation

final class APIDecoder {
 
    static func decodeAPIResponse<T: Decodable>(_ type: T.Type, from data: Data?) throws -> APIResponse<T> {
        guard let data else { throw APIError.missingData }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.attendance)
        return try decoder.decode(APIResponse<T>.self, from: data)
    }
    
}
