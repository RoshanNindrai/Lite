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

    subscript(key: Key) -> CacheResponse<Value> {
        get {
            let hashedKey = NSString(string: key.toString().sha1())
            if let expiryTimeInterval = expiryTable?.value(forKey: key.toString().sha1()) as? Date {
                let timeSinceLastCache = Date()
                if timeSinceLastCache.compare(expiryTimeInterval)  == .orderedDescending {
                    storage.removeObject(forKey: hashedKey)
                     return CacheResponse<Value>(nil, cacheExpiry: .Date(expiryTable?.value(forKey: hashedKey.toString()) as! Date))
                }
            }

            if let cachedData = storage.object(forKey: hashedKey) {
                return CacheResponse<Value>(cachedData, cacheExpiry: .Date(expiryTable?.value(forKey: hashedKey.toString()) as! Date))
            }
            return CacheResponse<Value>(nil, cacheExpiry: .Date(expiryTable?.value(forKey: hashedKey.toString()) as! Date))
        }
        set {
            if let toSaveData = newValue.val {
                let hashedKey = NSString(string: key.toString().sha1())
                expiryTable?.set(newValue.expiry?.time, forKey: hashedKey.toString())
                storage.setObject(toSaveData, forKey: hashedKey)
                expiryTable?.synchronize()
            }
        }
    }
}
