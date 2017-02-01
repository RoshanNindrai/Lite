//
//  MemoryCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

private let DEFAULT_MEMORY_SIZE = 50 * 1024 * 1024

public final class DummyCache<K, V>: NSObject {

    public typealias Key = K
    public typealias Value = V


}

extension DummyCache : CachePolicy {

    public func get(key: K) -> Future<V>? {
        print("Called Dummy get for key \(key)")
        return nil
    }

    public func set(key: K, value: V) {
        print("Called Dummy set for key \(key) \(value)")
    }

}
