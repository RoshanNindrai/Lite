//
//  Service.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation

final public class Webservice: NSObject {

    //contains all the plugins that is needed during load method
    fileprivate var plugins: [PluginType] = []

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

    /// This method is used to perform the url request and call the completion
    /// handler with the aquired resources
    ///
    /// - parameter resource:   The request resource that was asked by the user
    /// - parameter completion: The completion handler takes in a resource
    class func load<A>(_ session: URLSession? = shared.session, resource: Resource<A>, completion: @escaping (Response<A>) -> ()) {

        let mutatedResource: Resource<A> = shared.plugins.reduce(resource) { resource, plugin in
            return plugin.willMakeRequest(with: resource)
        }

        let request = URLRequest(resource: mutatedResource)

        session?.dataTask(with: request) { data, response, error in

            let modresponse = shared.plugins.reduce((data, response, error)) { response, plugin in
                return plugin.willParseResponse(response: response, for: mutatedResource)
            }

            if let data = modresponse.0 {
                completion(.success(mutatedResource.parse(data), modresponse.1, data))
            } else if let error = modresponse.2 {
                completion(.failure(error))
            }

        }.resume()

        _ = shared.plugins.map { plugin in
            plugin.didMakeRequest(with: mutatedResource, request: request)
        }

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
    class func load<A>(_ session: URLSession? = shared.session, resource: Resource<A>) -> Future<Response<A>> {
        return Future { completion in
            load(resource: resource, completion: completion)
        }
    }

}

//MARK: Plugin support

public extension Webservice {

    /// This method add a plugin type to the webservice
    ///
    /// - Parameter plugin: The actual plugin that needs to be added as part of the service
    class func add(plugin: PluginType) {
        shared.plugins.append(plugin)
    }

}

