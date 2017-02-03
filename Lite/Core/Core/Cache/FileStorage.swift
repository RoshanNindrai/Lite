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

    subscript(key: String, expiry: TimeInterval) -> Data? {
        get {
            let cacheFilePath = baseURL.appendingPathComponent(key.sha1())
            if let expiryDate = expiryTable?.value(forKey: key.sha1()) as? Date {
                let timeSinceLastCache = Date().timeIntervalSince(expiryDate)
                if timeSinceLastCache >= expiry {
                    if (FileManager.default.fileExists(atPath: cacheFilePath.path)) {
                        try! FileManager.default.removeItem(at: cacheFilePath)
                        return nil
                    }

                }
            }
            let url = baseURL.appendingPathComponent(key.sha1())
            return try? Data(contentsOf: url)
        }
        set {
            expiryTable?.set(Date(), forKey: key.sha1())
            let url = baseURL.appendingPathComponent(key.sha1())
            _ = try? newValue?.write(to: url)
        }
    }

    private func prepareFS() {
        var isDir : ObjCBool = false
        if (FileManager.default.fileExists(atPath: baseURL.absoluteString, isDirectory:&isDir)) {
            try! FileManager.default.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
        }
    }

}
