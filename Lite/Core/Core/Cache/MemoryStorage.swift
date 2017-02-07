//
//  MemoryStorage.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/4/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

let DEFAULT_MEMORY_SIZE = 50 * 1024 * 1024

public struct MemoryStorage<K: StringConvertable, V: AnyObject> {

    public typealias Key = K
    public typealias Value = V

    fileprivate var storage: NSCache<NSString, Value>
    var expiryTable = UserDefaults(suiteName: "com.lite.cache")

    init(path: String? = "com.lite.cache", capacity: Int = DEFAULT_MEMORY_SIZE) {
        storage = NSCache<NSString, Value>()
        storage.totalCostLimit = capacity
    }
}

public extension MemoryStorage {

    subscript(key: Key, expiry: CacheExpiry) -> Value? {
        get {
            let hashedKey = NSString(string: key.toString().sha1())
            if let expiryDate = expiryTable?.value(forKey: hashedKey.toString()) as? Date {
                let timeSinceLastCache = Date().timeIntervalSince(expiryDate)
                if timeSinceLastCache >= expiry.time {
                    storage.removeObject(forKey: hashedKey)
                    return nil
                }
            }

            if let cachedData = storage.object(forKey: hashedKey) {
                return cachedData
            }
            return nil
        }
        set {
            let hashedKey = NSString(string: key.toString().sha1())
            expiryTable?.set(Date(), forKey: hashedKey.toString())
            storage.setObject(newValue!, forKey: hashedKey)
            expiryTable?.synchronize()
        }
    }


}
