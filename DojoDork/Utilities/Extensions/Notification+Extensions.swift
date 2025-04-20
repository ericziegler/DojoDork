//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

extension Notification.Name {
    static let userLoggedIn = Notification.Name("userLoggedIn")
    static let userLoggedOut = Notification.Name("userLoggedOut")
    static let authenticationFailed = Notification.Name("authenticationFailed")
    static let metadataLoaded = Notification.Name("metadataLoaded")
}
