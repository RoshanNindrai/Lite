//
//  DiscCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public final class DiscCache<K: StringConvertable, V>: BaseCache<K, V> {

    public typealias Key = K
    public typealias Value = V
    fileprivate var storage : FileStorage?

    public override init() {
        super.init()
        storage = FileStorage()
    }
}

extension DiscCache : CachePolicy {

    public func get(key: K) -> Future<V>? {
        if let archievedData = storage?[key.toString(), expiry!] {
            let unArchivedData = NSKeyedUnarchiver.unarchiveObject(with: archievedData)
            return Future<V>(unArchivedData as? V)
        }

        return nil
    }

    public func set(key: K, value: V, expiry: CacheExpiry = .Never) {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        self.expiry = expiry
        storage?[key.toString(), self.expiry!] = data
    }

}
