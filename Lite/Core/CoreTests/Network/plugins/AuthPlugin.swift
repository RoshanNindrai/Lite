//
//  AuthPlugin.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 3/6/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation
import Core

enum TestError: Error {
    case Default
}


struct AuthPlugin: PluginType {

    let token = "Bearer: "+UUID().uuidString

    func willMakeRequest<P>(with resource: Resource<P>) -> Resource<P> {
        var modResource = resource
        modResource.addHeader(key: "Auth", Value: token)
        return modResource
    }

    func didMakeRequest<P>(with resource: Resource<P>, request: URLRequest) {
        assert(resource.getHeader().contains { key, value in
            return key == "Auth" && value == token
        })
    }

    func willParseResponse<P>(response: (Data?, URLResponse?, Error?), for resource: Resource<P>) -> (Data?, URLResponse?, Error?) {
        return (nil, response.1, TestError.Default)
    }

}
