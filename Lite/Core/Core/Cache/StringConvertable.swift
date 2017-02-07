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
}

//MARK: StringConvertable support for common key types

extension NSURL : StringConvertable {
    public func toString() -> String {
        return absoluteString!
    }
}

extension URL : StringConvertable {
    public func toString() -> String {
        return absoluteString
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
