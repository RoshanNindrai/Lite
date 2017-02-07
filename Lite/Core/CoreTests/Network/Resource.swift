//
//  File.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation
import Core

struct DummyGetResource {
    let origin : String
}

extension DummyGetResource {

    init?(dataDict : JSONDictionary) {
        guard let origin = dataDict["origin"] as? String else {
            return nil
        }
        self.origin = origin
    }
}

struct DummyPostResource {
    let formData : AnyObject
}

extension DummyPostResource {

    init?(dataDict : JSONDictionary) {
        guard let formStringData = dataDict["form"] else {
            return nil
        }
        self.formData = formStringData
    }
}
