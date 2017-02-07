//
//  Response.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 1/31/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation


/// This wraps the response from the server based on the state
///
/// - success: Wraps the actual data response and URLResponse for status code
/// - error: Wraps the error object that is returned by th URLSession
public enum Response<A> {
    case success(A?, URLResponse?, Data?)
    case failure(Error)
}
