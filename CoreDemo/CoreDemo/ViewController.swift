//
//  ViewController.swift
//  CoreDemo
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 2/10/17.
//  Copyright © 2017 lite. All rights reserved.
//

import UIKit
import Core

struct DummyGetResource {
    let origin : String
}

extension DummyGetResource {

    init?(dataDict : JSONDictionary) {
        guard let origin = dataDict["origin"] as? String else {
            return nil
        }
        self.origin = origin
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func makeCall(_ sender: Any) {
        testCacheWebService()
    }

    func testCacheWebService() {

        let test = Resource<DummyGetResource>(url: URL(string:"https://httpbin.org/cache/60")!,
                                              type:.GET,
                                              cacheExpiry:.Hours(10),
                                              parseJSON: {json in
                                                guard let dictionaries = json as? JSONDictionary else { return nil }
                                                return DummyGetResource.init(dataDict: dictionaries)
        })

        _ = CachedWebservice().load(resource: test, completion: { result in
            if case let Response.success(data, _, _) = result {
                print(data?.origin ?? "No origin value")
            }
        })

    }

}



