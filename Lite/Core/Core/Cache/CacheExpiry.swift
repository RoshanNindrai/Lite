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
    case Date(Date)
}

public extension CacheExpiry {
    var time : Date {
        switch self {
        case .Never:
            return Foundation.Date().addingTimeInterval(TimeInterval(DEFAULT_EXPIRY_SIZE))
        case .Seconds(let seconds):
            return Foundation.Date().addingTimeInterval(TimeInterval(seconds))
        case .Hours(let hours):
            let hour = hours * 60 * 60
            return Foundation.Date().addingTimeInterval(TimeInterval(hour))
        case .Days(let days):
            let days = days * 24 * 60 * 60
            return Foundation.Date().addingTimeInterval(TimeInterval(days))
        case .Date(let date):
            return date
        }
    }
}
