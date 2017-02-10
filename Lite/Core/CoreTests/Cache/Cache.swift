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

    func testCombineAndExpiry() {
        let memoryCache = MemoryCache<String, NSString>()
        let discCache = DiscCache<String, NSString>()
        let combined = discCache.compose(memoryCache)
        combined.set(key: "cache_key", value: "No No", expiry: .Seconds(5))
        assert(discCache.get(key: "cache_key")?.val == "No No", "The Cache hit didnt occured for cache_key")
        assert(memoryCache.get(key: "cache_key")?.val == "No No", "The Cache hit didnt occured for cache_key")
        sleep(2)
        //assert(discCache.get(key: "cache_key")?.val == "No No", "The Cache hit didnt occured for cache_key")
        assert(memoryCache.get(key: "cache_key")?.val == "No No", "The Cache was not deleted by to expiry rule")
        print(combined.get(key: "cache_key")?.val ?? "No value found for key Hello World")
    }

    func testDiscCacheExpiry() {
        let discCache = DiscCache<String, NSString>()
        discCache.set(key: "cache_key", value: "No No")
        assert(discCache.get(key: "cache_key")?.val == "No No", "The Cache hit didnt occured for cache_key")
        sleep(6)
        assert(discCache.get(key: "cache_key")?.val == nil, "The Cache was not deleted by to expiry rule")
    }

    func testMemoryCacheExpiry() {
        let memoryCache = MemoryCache<String, NSString>()
        memoryCache.set(key: "cache_key", value: "cache_value", expiry: .Seconds(5))
        assert(memoryCache.get(key: "cache_key")?.val == "cache_value", "The Cache hit didnt occured for cache_key")
        sleep(6)
        assert(memoryCache.get(key: "cache_key")?.val == nil, "The Cache was not deleted by to expiry rule")
    }

}
