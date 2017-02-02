//
//  StringConvertable.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/2/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public protocol StringConvertable {
    func toString() -> String
}

extension NSURL : StringConvertable {
    public func toString() -> String {
        return absoluteString!
    }
}

extension String : StringConvertable {
    public func toString() -> String {
        return self
    }
}

extension NSString : StringConvertable {
    public func toString() -> String {
        return self as String
    }
}
