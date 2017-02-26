//
//  FileStorage.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/2/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

struct FileStorage {

    var basePath : String?
    var expiryTable = UserDefaults(suiteName: "com.lite.cache")
    var baseURL = try! FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil, create: true)

    init(path: String? = "com.lite.cache") {
        basePath = path
        baseURL = baseURL.appendingPathComponent(basePath!, isDirectory: true)
        prepareFS()
    }

    subscript(key: String) -> CacheResponse<Data> {
        get {
            guard expired(for: key) else {
                return loadCache(for: key)
            }
            clearCache(for: key)
            return CacheResponse<Data>(nil, cacheExpiry: .Date(Date()))
        }
        set {
            expiryTable?.set(newValue.expiry!.time, forKey: key.sha1())
            let url = baseURL.appendingPathComponent(key.sha1())
            _ = try! newValue.val!.write(to: url)
        }
    }

    private func expired(for key: String) -> Bool {
        if let expiryTimeInterval = expiryTable?.value(forKey: key.sha1()) as? Date {
            let timeSinceLastCache = Date()
            if timeSinceLastCache.compare(expiryTimeInterval) == .orderedDescending {
                return true
            }
            else { return false }
        }
        return true
    }

    private func loadCache(for key: String) -> CacheResponse<Data> {
        let url = baseURL.appendingPathComponent(key.sha1())
        let data = try! Data(contentsOf: url)
        let expiryTimeInterval = expiryTable?.value(forKey: key.sha1()) ?? CacheExpiry.Never.time
        return CacheResponse<Data>(data, cacheExpiry: .Date(expiryTimeInterval as! Date))
    }

    private func clearCache(for key: String) -> () {
        let cacheFilePath = baseURL.appendingPathComponent(key.sha1())
        if (FileManager.default.fileExists(atPath: cacheFilePath.path)) {
            try! FileManager.default.removeItem(at: cacheFilePath)
        }
    }

    private func prepareFS() {
        var isDir : ObjCBool = false
        if (!FileManager.default.fileExists(atPath: baseURL.path, isDirectory:&isDir)) {
            try! FileManager.default.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
        }
    }

}
