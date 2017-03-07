//
//  AsyncOperation.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 3/4/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation

public enum State: String {
    case Ready, Executing, Finished

    var keyPath: String {
        return isPrefixed()
    }

    private func isPrefixed() -> String {
        return "is" + rawValue
    }
}

public class AsyncOperation : Operation {

    override public var isAsynchronous: Bool { return true }

    var handle : ((AsyncOperation) -> ())

    public var state: State = .Ready {
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
    }

    override public var isExecuting: Bool {
        return state == .Executing
    }

    override public var isFinished: Bool {
        return state == .Finished
    }

    public init(_ handle: @escaping ((AsyncOperation) -> ())) {
        self.handle = handle
    }

    override public func start() {
        if isCancelled {
            state = .Finished
        }
        else {
            state = .Executing
            main()
        }
    }

    override public func main() {
        if isCancelled {
            state = .Finished
        }
        handle(self)
    }

}
