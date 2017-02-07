//
//  Future.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class Future<T> : NSObject, NSCoding {

    public required init?(coder aDecoder: NSCoder) {
        internalValue = aDecoder.decodeObject(forKey: "internal_value") as? T
    }
//
//    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(internalValue, forKey: "internal_value")
//    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(internalValue, forKey: "internal_value")
    }

    fileprivate var internalValue : T?
    init(_ value: T?) {
        internalValue = value
    }
}

public extension Future {
    public var val: T? {
        get { return internalValue }
    }

}
