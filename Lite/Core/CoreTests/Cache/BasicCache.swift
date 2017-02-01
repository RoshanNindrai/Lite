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

        let dummyCache = DummyCache<NSString, NSString>()
        let memoryCache = MemoryCache<NSString, NSString>()
        let combined = dummyCache.compose(memoryCache).compose(dummyCache)
        combined.set(key: "Hello", value: "Value Stored")
        print(combined.get(key: "Hello")?.value ?? "No value found for key Hello World")
    }

}
