//
//  MonoCacheProtocol.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

let DEFAULTEXPIRYSIZE = 365 * 24 * 60 * 60

public protocol CachePolicy {

    associatedtype Key: StringConvertable
    associatedtype Value

    func get(key: Key) -> Future<CacheResponse<Value>>
    func set(key: Key, value: Value, expiry : CacheExpiry?)
    
}


public extension CachePolicy {
    func compose<B: CachePolicy>(_ cache: B) -> BasicCache<Key, Value> where B.Key == Key, B.Value == Value {
        return BasicCache(getC: { key in
            return self.get(key: key)
                       .flatMap { cacheResponse in
                        if cacheResponse.val != nil {
                            return Future<CacheResponse<Value>> { completion in
                                completion(cacheResponse)
                            }
                        }
                        else {
                            return cache.get(key: key)
                        }
            }
        }, setC: {key, value, expiry in
            self.set(key: key, value: value, expiry: expiry)
            cache.set(key: key, value: value, expiry: expiry)
        })
    }
}
