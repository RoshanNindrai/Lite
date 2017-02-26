//
//  Request.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation


/// This represent the kind of network activity that is gonna takes place
///
/// - POST:   used for a post request
/// - GET:    used for a get request
/// - DELETE: used for a delete request
/// - PUT:    used for a put request
public enum RequestType<Body> {
    case GET
    case POST(Body)
    case DELETE(Body)
    case PUT(Body)
}


extension RequestType {

    /// Return the http method as string
    var method : String {
        switch self {
            case .GET: return "GET"
            case .POST: return "POST"
            case .DELETE: return "DELETE"
            case .PUT: return "PUT"
        }
    }

}

extension RequestType {

    func map<B>(_ function: (Body) -> B) -> RequestType<B> {

        switch self {
            case .GET: return .GET
            case .POST(let body): return .POST(function(body))
            case .DELETE(let body): return .DELETE(function(body))
            case .PUT(let body): return .PUT(function(body))
        }

    }

}
