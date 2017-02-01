//
//  Future.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public struct Future<Value> {
    fileprivate var internalValue : Value?
    init(_ value: Value?) {
        internalValue = value
    }
}

extension Future {
    var value: Value? {
        get { return internalValue }
    }

}
