//
//  MutableURLRequest+Utils.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 1/3/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

extension URLRequest {

    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        httpMethod = resource.httpMethod.method
        allHTTPHeaderFields = resource.header

        if case let .POST(data) = resource.httpMethod {
            httpBody = data
        }
        else if case let .DELETE(data) = resource.httpMethod {
            httpBody = data
        }
        else if case let .PUT(data) = resource.httpMethod {
            httpBody = data
        }
    }

}
