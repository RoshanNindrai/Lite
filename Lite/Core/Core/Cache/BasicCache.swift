//
//  BasicCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class BasicCache<K, V> : NSObject {

    public typealias getClosure = (_ Key: K) -> Future<V>?
    public typealias setClosure = (_ Key: K, _ value: V) -> Void

    public typealias Key = K
    public typealias Value = V

    fileprivate var getC : getClosure
    fileprivate var setC : setClosure

    public init(getC: @escaping getClosure, setC: @escaping setClosure) {
        self.getC = getC
        self.setC = setC
    }

}


extension BasicCache : CachePolicy {
    public func get(key: K) -> Future<V>? {
        return getC(key)
    }

    public func set(key: K, value: V) {
        setC(key, value)
    }
}
