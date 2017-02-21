//
//  Service.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation

final public class Webservice: NSObject {

    //  The configuration for the session that is to be handled
    fileprivate var sessionConfig : URLSessionConfiguration = .default {
        didSet { Webservice.shared.sessionConfig = sessionConfig }
    }
    //  The actual session object
    fileprivate var session : URLSession
    //  shared object for performing all WebService calls
    static let shared : Webservice = Webservice()

    override init() {
        session = URLSession.init(configuration: sessionConfig)
    }
}

public extension Webservice {

    /// To add custom session configuration to the URLSession
    ///
    /// - parameter config: configuration for the session configuration
    func sessionConfiguration(config : URLSessionConfiguration) {
        sessionConfig = config
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
    }

}

public extension Webservice {

    /// This method is used to perfrom the url request and call the completion
    /// handler with the aquired resources
    ///
    /// - parameter resource:   The request resource that was asked by the user
    /// - parameter completion: The completion handler takes in a resource
    class func load<A>(_ session: URLSession? = shared.session, resource: Resource<A>, completion: @escaping (Response<A>) -> ()) {

        let request = URLRequest(resource: resource)
        session?.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(.success(resource.parse(data), response, data))
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()

    }

    /// This method is used to perfrom the url request and call the completion
    /// handler with the aquired resources
    ///
    /// - parameter resource:   The request resource that was asked by the user
    /// - parameter completion: The completion handler takes in a resource
    class func download<A>(_ session: URLSession? = shared.session,
                        resource: Resource<A>, completion: @escaping (Response<URL>) -> ()){

        let request = URLRequest(resource: resource)
        session?.downloadTask(with: request) { url, response, error in
            if let url = url {
                completion(.success(url, response, nil))
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
        
    }


    /// This method is responsible for cancelling an ongoing task
    ///
    /// - Parameters:
    ///   - session: The session to which the resource call was sent to
    ///   - resource: The actual resource that is requested from the session
    class func cancel<A>(_ session: URLSession? = shared.session, resource: Resource<A>) {
        getTask(session, resource: resource) { task in task.cancel() }
    }


    /// To get the specific task that is associated with a session
    ///
    /// - Parameters:
    ///   - session: The session that is currently executing the resource
    ///   - resource: The resource for which the task is requested
    /// - Returns: A URLSessionTask that is associated with the resource
    class func getTask<A>(_ session: URLSession? = shared.session, resource: Resource<A>, onResult: @escaping ((URLSessionTask) -> ())){
        session?.getAllTasks { tasks in
            _ = tasks.filter { $0.originalRequest?.url?.absoluteString == resource.url.absoluteString }
                .map {  task in onResult(task) }
        }
    }

    /// This method is used to perform the url request and call the completion
    /// handler with the aquired resources
    ///
    /// - parameter resource:   The request resource that was asked by the user
    /// - parameter completion: The completion handler takes in a resource
    class func load<A>(_ session: URLSession? = shared.session, resource: Resource<A>) -> Future<A> {

        return Future { completion in

            let request = URLRequest(resource: resource)
            session?.dataTask(with: request) { data, response, error in
                if let data = data {
                    completion(.success(resource.parse(data), response, data))
                } else if let error = error {
                    completion(.failure(error))
                }
                }.resume()

        }
        
    }

}
