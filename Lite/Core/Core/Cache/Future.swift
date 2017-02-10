//
//  Future.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class Future<T> : NSObject {

    public required init?(coder aDecoder: NSCoder) {
        internalValue = aDecoder.decodeObject(forKey: "internal_value") as? T
    }

    var expiry: Date?
    fileprivate var internalValue : T?
    
    init(_ value: T?, cacheExpiry: Date) {
        internalValue = value
        expiry = cacheExpiry
    }
}

public extension Future {
    public var val: T? {
        get { return internalValue }
    }
}
