//
//  MemoryCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

private let DEFAULT_MEMORY_SIZE = 50 * 1024 * 1024

final class MemoryCache<K: Hashable, V: AnyObject> {

    public typealias Key = NSString
    public typealias Value = V

    fileprivate var storage: NSCache<Key, Value>

    init(capacity : Int = DEFAULT_MEMORY_SIZE) {
        storage = NSCache<Key, Value>()
        storage.totalCostLimit = capacity
    }

}

extension MemoryCache : CachePolicy {

    func get(key: NSString) -> Future<V>? {

        guard let value = storage.object(forKey: key) else {
            return nil
        }

        return Future<V>(value)

    }

    func set(key: NSString, value: V) {
        storage.setObject(value, forKey: key)
    }
}
