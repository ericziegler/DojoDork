//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

typealias Parameters = [String: Any]
typealias Credentials = [String: String]

let APIURL = "https://dojodork.dojovista.com/api/v1"

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
