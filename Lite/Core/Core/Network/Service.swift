//
//  Service.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation


/// This wraps the response from the server based on the state
///
/// - success: Wraps the actual data response and URLResponse for status code
/// - error: Wraps the error object that is returned by th URLSession
public enum Response<A> {
    case success(A?, URLResponse?)
    case error(Error)
}

final public class Webservice {

    //  The configuration for the session that is to be handled
    fileprivate var sessionConfig : URLSessionConfiguration = .default
    //  The actual session object
    fileprivate var session : URLSession?
    //  shared object for performing all WebService calls
    static let shared : Webservice = Webservice()

    init() {
        session = URLSession(configuration: sessionConfig)
    }
}

public extension Webservice {

    /// To add custom session configuration to the URLSession
    ///
    /// - parameter config: configuration for the session configuration
    func sessionConfiguration(config : URLSessionConfiguration) {
        sessionConfig = config
    }

}

public extension Webservice {

    /// This method is used to perfrom the url request and call the completion
    /// handler with the aquired resources
    ///
    /// - parameter resource:   The request resource that was asked by the user
    /// - parameter completion: The completion handler takes in a resource
    class func load<A>( resource: Resource<A>, completion: @escaping (Response<A>) -> ()) -> URLSessionTask? {

        let request = URLRequest.init(resource: resource)
        let task = shared.session?.dataTask(with: request) { data, response, error in

            if let data = data {
                completion(Response.success(resource.parse(data), response))
            } else if let error = error {
                completion(Response.error(error))
            }
        }

        task?.resume()
        return task

    }
}


