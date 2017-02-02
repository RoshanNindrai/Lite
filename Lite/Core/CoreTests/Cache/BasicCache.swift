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
        let dummyCache = DummyCache<String, NSString>()
        let discCache = DiscCache<String, NSString>()
        //let memoryCache = MemoryCache<NSString, NSString>()
        let combined = discCache.compose(dummyCache)
        combined.set(key: "https://www.youtube.com/watch?v=v8eUuzElvX4", value: "Thendral Vanthu")
        print(combined.get(key: "https://www.youtube.com/watch?v=v8eUuzElvX4")?.value ?? "No value found for key Hello World")
    }

}
