//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

protocol CacheServiceProtocol {
    func loadData(for key: String) -> Data?
    func save(data: Data, for key: String)
    func removeData(for key: String)
}
