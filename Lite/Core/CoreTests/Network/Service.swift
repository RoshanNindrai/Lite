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

        let task = Webservice.load(resource: test, completion: { result in

            switch result {
            case .success(let data, let httpResponse):
                if let httpResponse = httpResponse as? HTTPURLResponse {
                    print("reponse status code \(httpResponse.statusCode)")
                }
                if let reponsedata = data { print(reponsedata) }
            case .failure(let error):
                print("OMG ERROR \(error.localizedDescription)")

            }

            asyncExpectation.fulfill()

        })

        task?.cancel()

        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "network GET test passed")
        }


    }

}
