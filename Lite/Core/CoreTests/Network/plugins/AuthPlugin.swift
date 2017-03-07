//
//  AuthPlugin.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 3/6/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation
import Core

struct AuthPlugin: PluginType {
    func willMakeRequest<P>(with resource: Resource<P>) -> Resource<P> {
        var modResource = resource
        modResource.addHeader(key: "Auth", Value: "Bearer"+UUID().uuidString)
        return modResource
    }

    func didMakeRequest<P>(with resource: Resource<P>, request: URLRequest) {
        print(resource)
    }

}
