//
//  Service.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 1/1/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation
import Core

class WebServiceTest : CoreTests {

    func testWebServiceCancel() {

        let asyncExpectation = expectation(description: "Making GET Call")

        let test = Resource<DummyGetResource>(url: URL(string:"https://httpbin.org/get")!,
                                              type:.GET,
                                              parseJSON: {json in
                                                guard let dictionaries = json as? JSONDictionary else { return nil }
                                                return DummyGetResource.init(dataDict: dictionaries)
        })

        let task = Webservice.load(resource: test, completion: { data, response, error in

            if error != nil {
                print("OMG ERROR \(error?.localizedDescription)")
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("reponse status code \(httpResponse.statusCode)")
            }

            if data != nil {
                print(data?.origin ?? "No data origin to print")
            }

            asyncExpectation.fulfill()

        })

        task?.cancel()

        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "network GET test passed")
        }


    }

}
