//
//  Future.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/11/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public class Future<T> {
    var callbacks:[(T) -> ()] = []
    var cached: T?

    init(_ compute: (@escaping (T) -> ()) -> ()) {
        compute(send)
    }

    private func send(_ result: T) {
        assert(cached == nil)
        cached = result
        callbacks.forEach { callback in
            callback(cached!)
        }
        callbacks = []
    }

    @discardableResult
    public func onResult(_ callback:(@escaping (T) -> ())) -> Future<T> {
        if let result = cached {
            callback(result)
        } else {
            callbacks.append(callback)
        }
        return self
    }

    @discardableResult
    public func flatMap<B>(_ transform: @escaping (T) -> Future<B>) -> Future<B> {
        return Future<B> { completion in
            onResult { result in
                transform(result).onResult(completion)
            }
        }
    }

}
