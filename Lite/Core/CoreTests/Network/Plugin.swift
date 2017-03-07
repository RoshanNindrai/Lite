//
//  Plugin.swift
//  Core
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 3/6/17.
//  Copyright © 2017 lite. All rights reserved.
//

import Foundation
import Core

class PluginTest: CoreTests {

    func testPlugin() {

        let asyncExpectation = expectation(description: "Making GET Call")

        let test = Resource<DummyGetResource>(url: URL(string:"https://httpbin.org/get")!,
                                              type:.GET,
                                              parseJSON: {json in
                                                guard let dictionaries = json as? JSONDictionary else { return nil }
                                                return DummyGetResource(dataDict: dictionaries)
        })

        Webservice.add(plugin: AuthPlugin())

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


}
