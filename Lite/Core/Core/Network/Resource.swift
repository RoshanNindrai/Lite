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
    let httpMethod : RequestType<Data>
    let parse : (Data) -> R?

    var header: [String:String]?

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
         type : RequestType<AnyObject> = .GET,
         header: [String:String]? = nil,
         parseJSON: @escaping (Any) -> R?) {

        self.url = url
        self.header = header
        parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data,
                                                         options : [])
            return json.flatMap(parseJSON)
        }

        httpMethod = type.map() { json in
            return (json as! Dictionary<String, String>).queryString().data(using: .utf8)!
        }

    }

}
