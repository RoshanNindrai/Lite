//
//  CacheExpiry.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/3/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public enum CacheExpiry {
    case Never
    case Seconds(Int)
    case Hours(Int)
    case Days(Int)
}

public extension CacheExpiry {
    var time : TimeInterval {
        switch self {
        case .Never:
            return TimeInterval(DEFAULT_EXPIRY_SIZE)
        case .Seconds(let seconds):
            return TimeInterval(seconds)
        case .Hours(let hours):
            let hour = hours * 60 * 60
            return TimeInterval(hour)
        case .Days(let days):
            let days = days * 24 * 60 * 60
            return TimeInterval(days)
        }
    }
}
