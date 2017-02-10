//
//  NetworkFetcher.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/10/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public final class NetworkFetcher<K: StringConvertable, V>: BaseCache<K, V> {

    public typealias Key = K
    public typealias Value = V

}

extension NetworkFetcher : CachePolicy {

    public func get<A>(resource: Resource<A>) -> Future<V>? {
//        return Webservice.load(resource: resource, completion: { result in
//            switch result {
//            case let .failure(error):
//                completion(.failure(error))
//            case let .success(data):
//                if let serverResponse = data.2 {
//                    self.cache.set(key: resource.url, value: NSData(data: serverResponse), expiry: (resource.cacheExpiry?.time)!)
//                    completion(.success(data.0, data.1, serverResponse))
//                }
//            }
//        })

        Webservice.load(resource: resource, completion: { result in
                        switch result {
                        case let .failure(error):
                            completion(.failure(error))
                        case let .success(data):
                            if let serverResponse = data.2 {
                                self.cache.set(key: resource.url, value: NSData(data: serverResponse), expiry: (resource.cacheExpiry?.time)!)
                                completion(.success(data.0, data.1, serverResponse))
                            }
                        }
        })

    }

    public func set(key: K, value: V, expiry: Date? = CacheExpiry.Seconds(5).time) {
        return
    }
    
}
