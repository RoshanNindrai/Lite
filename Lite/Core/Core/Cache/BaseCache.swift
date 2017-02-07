//
//  BaseCache.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/4/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public  class BaseCache<K, V>: NSObject {
    public typealias Key = K
    public typealias Value = V
    public var expiry: CacheExpiry?

    override init() {
        super.init()
        expiry = .Never
    }

}
