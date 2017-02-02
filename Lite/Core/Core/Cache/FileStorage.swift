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
    var baseURL = try! FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil, create: true)

    init(path: String? = "com.lite.cache") {
        basePath = path
        baseURL = baseURL.appendingPathComponent(basePath!, isDirectory: true)
        try! FileManager.default.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
    }

    subscript(key: String) -> Data? {
        get {
            let url = baseURL.appendingPathComponent(key.sha1())
            return try? Data(contentsOf: url)
        }
        set {
            let url = baseURL.appendingPathComponent(key.sha1())
            _ = try? newValue?.write(to: url)
        }
    }

}
