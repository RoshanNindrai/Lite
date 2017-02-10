//
//  CacheFactory.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/4/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public struct CacheFactory<K: StringConvertable, V: AnyObject> {

    static var defaultCache: BasicCache<K, V> {
        let memoryCache = MemoryCache<K, V>()
        let discCache = DiscCache<K, V>()
        return memoryCache.compose(discCache)
    }

}

