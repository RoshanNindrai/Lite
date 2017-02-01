//
//  MonoCacheProtocol.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public protocol CachePolicy {

    associatedtype Key
    associatedtype Value

    func get(key: Key) -> Future<Value>?
    func set(key: Key, value: Value)
    
}

public extension CachePolicy {
    func compose<B: CachePolicy>(cache: B) -> BasicCache<Key, Value> where B.Key == Key, B.Value == Value {
        return BasicCache(getC: { key in
            if let _ = self.get(key: key) {
                return nil
            }
            else {
                return cache.get(key: key)
            }
        }, setC: {key, value in
            self.set(key: key, value: value)
        })
    }
}
