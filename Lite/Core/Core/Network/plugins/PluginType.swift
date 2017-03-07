//
//  PluginType.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 3/6/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public protocol PluginType {

    /// This method is fired before making a resource request using the Webservice load method
    ///
    /// - Parameters:
    ///   - resource: The actual resource for which a response is requested
    /// - Returns: A resource object that would be used to perform the resource request
    func willMakeRequest<P>(with resource: Resource<P>) -> Resource<P>

    /// This method is fired after making a resource request
    ///
    /// - Parameters:
    ///   - resource: The actual resource for which a response is requested
    ///   - resquest: The actual URLRequest that was made to the server
    func didMakeRequest<P>(with resource: Resource<P>, request: URLRequest)

    /// This method is fired after getting the network response but before calling the parse method within the resource
    ///
    /// - Parameters:
    ///   - response: The actual raw response from the dataTask on URLSession
    ///   - resource: The actual resource for which a response is requested
    /// - Returns: Returns an intercepted response object for resource parser to parse
    func willParseResponse<P>(response: (Data?, URLResponse?, Error?), for resource:Resource<P>) -> (Data?, URLResponse?, Error?)

}

extension PluginType {
    public func willMakeRequest<P>(with resource: Resource<P>) -> Resource<P> { return resource }
    public func didMakeRequest<P>(with resource: Resource<P>, request: URLRequest) {}
    public func willParseResponse<P>(response: (Data?, URLResponse?, Error?), for resource:Resource<P>) -> (Data?, URLResponse?, Error?) { return response }
}
