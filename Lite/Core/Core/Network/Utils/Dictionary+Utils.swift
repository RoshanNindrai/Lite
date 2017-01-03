//
//  Dictionary+Utils.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 uniqlabs. All rights reserved.
//

import Foundation


public extension Dictionary {

    func queryString() -> String {

        return reduce("") { (result, content) in

            var previous_query = result
            if previous_query.characters.count != 0 {
                previous_query.append("&\(content.key)=\(content.value)")
            }
            else {
                previous_query.append("\(content.key)=\(content.value)")
            }

            return previous_query

        }
    }

}
