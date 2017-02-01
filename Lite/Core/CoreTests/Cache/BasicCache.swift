//
//  BasicCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation
import Core

class BasicCacheTest : CoreTests {

    func testCombine() {
        let cache = BasicCache<String, NSData>.init(getC: {key in
            print("Memory Cache hit")
            return nil
        }, setC: {key, value in
            print(key)
            print(value)
        })
        let discCache = BasicCache<String, NSData>.init(getC: {key in
            print("Disc Cache hit")
            return nil
        }, setC: {key, value in
            print(key)
            print(value)
        })

        let combined = cache.compose(cache: discCache)
        let _ = combined.get(key: "Hello World")
    }

}
