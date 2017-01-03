//
//  NetworkRequestTest.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation
import Core

class NetworkRequestTest: CoreTests {

    func testNetworkGetRequest() {

        let asyncExpectation = expectation(description: "Making GET Call")

        let test = Resource<DummyGetResource>(url: URL(string:"https://httpbin.org/get")!,
                                          type:.GET,
                                          parseJSON: {json in
                                            guard let dictionaries = json as? JSONDictionary else { return nil }
                                            return DummyGetResource.init(dataDict: dictionaries)
        })

        _ = Webservice.load(resource: test, completion: { data, response, error in
            print(data?.origin ?? "No origin value")
            asyncExpectation.fulfill()
        })

        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "network GET test passed")
        }

    }

    func testNetworkPostRequest() {

        let asyncExpectation = expectation(description: "Making POST Call")

        var test : Resource = Resource<DummyPostResource>(url: URL(string:"https://httpbin.org/post")!,
                                              type:.POST,
                                              parseJSON: {json in
                                                guard let dictionaries = json as? JSONDictionary else { return nil }
                                                return DummyPostResource.init(dataDict: dictionaries)
        })

        test.parameter(parameter: ["echo":"value"])

        _ = Webservice.load(resource: test, completion: { data, response, error in
            assert(data?.formData != nil)
            assert(data?.formData as! [String:String] == ["echo":"value"])
            asyncExpectation.fulfill()
        })

        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "network POST test passed")
        }
        
    }


}