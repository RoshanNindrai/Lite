//
//  Resource.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]

/// This struct is used to represent a resource
public struct Resource<R> {

    let url : URL
    let type : RequestType?
    let parse : (Data) -> R?

    fileprivate var header : [String : String]?
    fileprivate var parameters : [String : Any]?
    fileprivate var request : URLRequest?

}

public extension Resource {

    /// This method is used to create a resource object with json parser
    ///
    /// - parameter url:       url of the request
    /// - parameter parseJSON: json parser function
    /// - parameter header:    header for the request if AnyObject
    ///
    /// - returns: returns a Resource that can be handed over to WebService
    init(url: URL,
         type : RequestType = .GET,
         parseJSON: @escaping (Any) -> R?) {

        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data,
                                                         options : [])
            return json.flatMap(parseJSON)
        }
        self.type = type
        createRequest()
    }

}


// MARK: - Setters
public extension Resource {

    mutating func header(header: [String: String]) {
        self.header = header
        request?.allHTTPHeaderFields = self.header
    }


    /// This method adds the httpBody Prameters
    ///
    /// - Parameter parameter: The http body for requests
    mutating func parameter(parameter: [String: Any]) {
        self.parameters = parameter
        request?.httpBody = self.parameters?.queryString().data(using: .utf8)
    }

}

public extension Resource {

    /// This method creates a URLRequest for a resource
    ///
    /// - returns: a URLRequest for URLSession
    func urlRequest() -> URLRequest {
        return request!
    }

    /// This method create the URLRequest object
    mutating func createRequest() {
        request = URLRequest(url:url)
        request!.httpMethod = self.type!.rawValue
    }
}

