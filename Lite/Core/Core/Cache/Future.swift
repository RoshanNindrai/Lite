//
//  Future.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public struct Future<T> {
    fileprivate var internalValue : T?
    init(_ value: T?) {
        internalValue = value
    }
}

public extension Future {
    public var value: T? {
        get { return internalValue }
    }

}
