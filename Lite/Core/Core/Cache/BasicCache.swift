//
//  BasicCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class BasicCache<K: StringConvertable, V> : BaseCache<K, V> {

    public typealias GetClosure = (_ Key: K) -> Future<CacheResponse<Value>>
    public typealias SetClosure = (_ Key: K, _ value: V, _ expiry: CacheExpiry) -> Void

    public typealias Key = K
    public typealias Value = V

    fileprivate var getC : GetClosure
    fileprivate var setC : SetClosure

    public init(getC: @escaping GetClosure, setC: @escaping SetClosure) {
        self.getC = getC
        self.setC = setC
    }

}

extension BasicCache : CachePolicy {
    public func get(key: K) -> Future<CacheResponse<Value>> {
        return getC(key)
    }

    public func set(key: K, value: V, expiry: CacheExpiry? = CacheExpiry.Seconds(5)) {
        setC(key, value, expiry!)
    }

    public func get<A>(resource: Resource<A>) -> Future<CacheResponse<Value>> {
        return get(key: resource.url as! K)
    }
}
