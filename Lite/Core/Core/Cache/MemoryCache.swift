//
//  MemoryCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public final class MemoryCache<K: StringConvertable, V: AnyObject>: BaseCache<K, V> {

    public typealias Key = K
    public typealias Value = V

    fileprivate var storage: MemoryStorage<Key, Value>?

    public init(capacity : Int = DEFAULT_MEMORY_SIZE) {
        super.init()
        storage = MemoryStorage<Key, Value>()
    }

}

extension MemoryCache: CachePolicy {

    public func get(key: Key) -> Future<V>? {
        if let data = storage?[key] {
            return data
        }

        return nil
    }

    public func set(key: Key, value: V, expiry: Date? = CacheExpiry.Seconds(5).time) {
        storage?[key] = Future<V>.init(value, cacheExpiry: expiry!)
    }

}
