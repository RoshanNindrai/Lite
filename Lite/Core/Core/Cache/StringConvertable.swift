//
//  StringConvertable.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/2/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation


/// This protocol is used to represent a string
public protocol StringConvertable: Hashable {
    func toString() -> String
    func hashed() -> String
}

//MARK: StringConvertable support for common key types

extension NSURL : StringConvertable {
    public func toString() -> String {
        return absoluteString!
    }
    public func hashed() -> String {
        return toString().sha1()
    }

}

extension URL : StringConvertable {
    public func toString() -> String {
        return absoluteString
    }
    public func hashed() -> String {
        return toString().sha1()
    }

}

extension String : StringConvertable {
    public func toString() -> String {
        return self
    }
    public func hashed() -> String {
        return sha1()
    }
}

extension NSString : StringConvertable {
    public func toString() -> String {
        return self as String
    }
    public func hashed() -> String {
        return toString().sha1()
    }
}
