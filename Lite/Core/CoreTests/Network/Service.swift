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
                                                return DummyGetResource(dataDict: dictionaries)
        })

        Webservice.load(resource: test, completion: { result in

            switch result {
            case .success(let data, let httpResponse, _):
                if let httpResponse = httpResponse as? HTTPURLResponse {
                    print("reponse status code \(httpResponse.statusCode)")
                }
                if let reponsedata = data { print(reponsedata) }
            case .failure(let error):
                print("OMG ERROR \(error.localizedDescription)")
                asyncExpectation.fulfill()
            }
        })

        Webservice.cancel(resource: test)

        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "network GET test passed")
        }


    }

    func testWebServiceGetTask() {

        let asyncExpectation = expectation(description: "Making GET Call")

        let test = Resource<DummyGetResource>(url: URL(string:"https://httpbin.org/get")!,
                                              type:.GET,
                                              parseJSON: {json in
                                                guard let dictionaries = json as? JSONDictionary else { return nil }
                                                return DummyGetResource(dataDict: dictionaries)
        })

        Webservice.load(resource: test, completion: { result in

            switch result {
            case .success(let data, let httpResponse, _):
                if let httpResponse = httpResponse as? HTTPURLResponse {
                    print("reponse status code \(httpResponse.statusCode)")
                }
                if let reponsedata = data { print(reponsedata) }
            case .failure(let error):
                print("OMG ERROR \(error.localizedDescription)")
            }
        })

        Webservice.getTask(resource: test) { task in
            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "network GET test passed")
        }
        
        
    }

    func testCacheWebService() {

        let asyncExpectation = expectation(description: "Making GET Call")

        let test = Resource<DummyGetResource>(url: URL(string:"https://httpbin.org/cache")!,
                                              type:.GET,
                                              cacheExpiry:.Seconds(10),
                                              parseJSON: {json in
                                                guard let dictionaries = json as? JSONDictionary else { return nil }
                                                return DummyGetResource.init(dataDict: dictionaries)
        })

        _ = CachedWebservice().load(resource: test, completion: { result in
            if case let Response.success(data, _, _) = result {
                print(data?.origin ?? "No origin value")
            }
            asyncExpectation.fulfill()
        })

        waitForExpectations(timeout: 20.0) { (error) in
            print(error ?? "network GET test passed")
        }

    }

}
