//
// Created by Eric Ziegler on 4/19/25
//  

import Foundation

class CacheService: CacheServiceProtocol {
    
    private let userDefaults = UserDefaults()
    
    func loadData(for key: String) -> Data? {
        userDefaults.data(forKey: key)
    }
    
    func save(data: Data, for key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func removeData(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    func loadString(for key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func saveString(_ string: String, for key: String) {
        userDefaults.set(string, forKey: key)
    }
    
    func removeString(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
