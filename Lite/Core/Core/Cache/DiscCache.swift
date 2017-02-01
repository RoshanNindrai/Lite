//
//  DiscCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

struct FileStorage {
    var basePath : String?
    var baseURL = try! FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil, create: true)

    init(path: String? = "com.lite.cache") {
        basePath = path
        baseURL = baseURL.appendingPathComponent(basePath!, isDirectory: true)
    }

    subscript(key: String) -> Data? {
        get {
            let url = baseURL.appendingPathComponent(key)
            return try? Data(contentsOf: url)
        }
        set {
            let url = baseURL.appendingPathComponent(key)
            _ = try? newValue?.write(to: url)
        }
    }

}

public final class DiscCache<K, V>: NSObject {

    public typealias Key = String
    public typealias Value = Data

    fileprivate var storage : FileStorage?

    public override init() {
        super.init()
        storage = FileStorage(path: "mono")
    }

}

extension DiscCache : CachePolicy {

    public func get(key: String) -> Future<Data>? {
        return Future<Data>(storage![key])
    }

    public func set(key: String, value: Data) {
        storage![key] = value
    }

}

