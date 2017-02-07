//
//  CachedWebservice.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/4/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public final class CachedWebservice {

    typealias Key = URL
    typealias Value = NSData

    private let cache: BasicCache<Key, Value>

    public init() {
        cache = CacheFactory<Key, Value>.cache
    }

    public func load<A>(resource: Resource<A>, completion: @escaping (Response<A>) -> ()) -> URLSessionTask? {

        if let result = cache.get(key: resource.url){
            completion(.success(resource.parse(result.val as! Data), nil, nil))
            return nil
        }

        return Webservice.load(resource: resource, completion: { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                if let serverResponse = data.2 {
                    self.cache.set(key: resource.url, value: NSData.init(data: serverResponse))
                    completion(.success(data.0, data.1, serverResponse))
                }
            }
        })
    }

}
