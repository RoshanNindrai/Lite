//
//  CacheManager.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/26/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class PooledCache<K: StringConvertable, V> {

    public typealias Key = K
    public typealias Value = V

    fileprivate let lock: ReadWriteLock = PThreadReadWriteLock()
    fileprivate let cache: BasicCache<K, V>
    fileprivate var inFlight: [K: Future<CacheResponse<Value>>] = [:]

    public init(_ cache: BasicCache<K, V>) {
        self.cache = cache
    }
}

extension PooledCache: CachePolicy {

    public func get(key: Key) -> Future<CacheResponse<Value>> {

        if let inflightRequest = lock.withReadLock({ self.inFlight[key] }) {
            return inflightRequest.flatMap { (response) -> Future<CacheResponse<Value>> in
                return Future<CacheResponse<Value>> { completion in
                    completion(response)
                }
            }
        }
        
        let inflightRequest = cache.get(key: key)
        lock.withWriteLock { inFlight[key] = inflightRequest }
        return inflightRequest
    }

    public func set(key: Key, value: Value, expiry : CacheExpiry?) {
        cache.set(key: key, value: value, expiry: expiry)
    }
}
