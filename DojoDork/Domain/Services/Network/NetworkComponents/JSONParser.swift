//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

class JSONParser {
    static func parse<DecodableDataModel: Codable>(json: Data?, key: String? = nil) throws -> DecodableDataModel {
        guard let json = json else {
            throw APIError.decodingFailed
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // if the key is nil, assume returning the DecodedDataModel directly. if the key has a value, use it to grab the model embedded in the JSON
        if let key = key {
            // grab the entire response and decode it
            guard let jsonDict = try JSONSerialization.jsonObject(with: json, options: []) as? [String : Any] else {
                throw APIError.decodingFailed
            }
            
            guard let status = jsonDict["status"] else {
                throw APIError.decodingFailed
            }
            
            if let status = status as? String, status != "success" {
                if status == APIFailedToAuthenticateMessage ||
                status == APIFailedExpiredSessionMessage ||
                status == APIFailedInactiveUserMessage {
                    // failed to login. post a notification to log the user out and immediately end
                    NotificationCenter.default.post(name: Notification.Name.authenticationFailed, object: nil)
                    throw APIError.loginFailed
                } else {
                    throw APIError.server(status)
                }
            }
            
            // grab the model from the key passed in
            guard let modelDict = jsonDict[key] else {
                throw APIError.decodingFailed
            }
            
            // decode the model dictionary into a model
            let modelJSON = try JSONSerialization.data(withJSONObject: modelDict, options: .prettyPrinted)
            let model: DecodableDataModel = try decoder.decode(DecodableDataModel.self, from: modelJSON)
            return model
        } else {
            // no key, so model not embedded. decode the entire json into the model
            let model: DecodableDataModel = try decoder.decode(DecodableDataModel.self, from: json)
            return model
        }
    }
    
}
