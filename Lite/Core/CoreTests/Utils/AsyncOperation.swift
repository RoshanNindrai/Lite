//
//  AsyncOperation.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 3/4/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation
import Core

class AsyncOperationTest: CoreTests {


    func testAsyncOperation() {

        var testVariable = 0

        let testExpectation = expectation(description: "Async operations test")

        let task1 = AsyncOperation { operation in
            DispatchQueue.global().async {
                sleep(3)
                testVariable += 1
                operation.state = .Finished
            }
        }

        let task2 = AsyncOperation { operation in
            DispatchQueue.global().async {
                sleep(1)
                testVariable += 2
                operation.state = .Finished
                assert(testVariable == 3)
                testExpectation.fulfill()
            }
        }

        task2.addDependency(task1)

        let operationQueue = OperationQueue()
        operationQueue.addOperation(task2)
        operationQueue.addOperation(task1)

        waitForExpectations(timeout: 7) { error in
            print(error?.localizedDescription ?? "No error")
        }

    }


}
