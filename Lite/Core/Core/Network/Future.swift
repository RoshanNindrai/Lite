//
//  Future.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/11/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class Future<A> {
    var callbacks:[(Response<A>) -> ()] = []
    var cached: Response<A>?

    init(_ compute: (@escaping (Response<A>) -> ()) -> ()) {
        compute(self.send)
    }

    private func send(_ result: Response<A>) {
        assert(cached == nil)
        cached = result
        callbacks.forEach { callback in
            callback(cached!)
        }
        callbacks = []
    }

    @discardableResult
    public func onResult(_ callback:(@escaping (Response<A>) -> ())) -> Future<A> {
        if let result = cached {
            callback(result)
        } else {
            callbacks.append(callback)
        }
        return self
    }

    @discardableResult
    public func flatMap<B>(_ transform: @escaping ((A?, URLResponse?, Data?)) -> Future<B>) -> Future<B> {
        return Future<B> { completion in
            self.onResult { result in
                switch result {
                    case .success(let value):
                        transform(value).onResult(completion)
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }

}

