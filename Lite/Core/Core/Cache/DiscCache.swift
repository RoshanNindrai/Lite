//
//  DiscCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public final class DiscCache<K: StringConvertable, V: NSCoding>: NSObject {

    public typealias Key = K
    public typealias Value = V

    public var expiry: TimeInterval?

    fileprivate var storage : FileStorage?

    public init(expiry: CacheExpiry = .Never) {
        super.init()
        storage = FileStorage()
        self.expiry = expiry.time
    }
}

extension DiscCache : CachePolicy {

    public func get(key: K) -> Future<V>? {
        if let archievedData = storage![key.toString(), expiry!] {
            let unArchivedData = NSKeyedUnarchiver.unarchiveObject(with: archievedData)
            return Future<V>(unArchivedData as? V)
        }

        return nil
    }

    public func set(key: K, value: V) {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        storage![key.toString(), expiry!] = data
    }

}
