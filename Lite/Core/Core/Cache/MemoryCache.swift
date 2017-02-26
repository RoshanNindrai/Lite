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
        storage = MemoryStorage<Key, Value>(capacity: capacity)
    }

}

extension MemoryCache: CachePolicy {

    public func get(key: Key) -> Future<CacheResponse<V>> {
        return Future<CacheResponse<V>> { completion in
            completion((storage?[key])!)
        }
    }

    public func set(key: Key, value: V, expiry: CacheExpiry? = CacheExpiry.Seconds(5)) {
        storage?[key] = CacheResponse<V>.init(value, cacheExpiry: expiry!)
    }

}
