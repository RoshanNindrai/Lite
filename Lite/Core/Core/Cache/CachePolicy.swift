//
//  MonoCacheProtocol.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

let DEFAULT_EXPIRY_SIZE = 365 * 24 * 60 * 60

public protocol CachePolicy {

    associatedtype Key: StringConvertable
    associatedtype Value

    var expiry : CacheExpiry? { get }

    func get(key: Key) -> Future<Value>?
    func set(key: Key, value: Value, expiry : CacheExpiry)
    
}


public extension CachePolicy {
    func compose<B: CachePolicy>(_ cache: B) -> BasicCache<Key, Value> where B.Key == Key, B.Value == Value {
        return BasicCache(getC: { key in
            if let data = self.get(key: key) {  return data }
            else { return cache.get(key: key) }
        }, setC: {key, value, expiry in
            self.set(key: key, value: value, expiry: expiry)
            cache.set(key: key, value: value, expiry: expiry)
        })
    }
}
