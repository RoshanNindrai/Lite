//
//  Dictionary+Utils.swift
//  ULCore
//
//  Created by Roshan Balaji Nindrai SenthilNatha on 12/31/16.
//  Copyright © 2016 lite. All rights reserved.
//

import Foundation

class DictionaryUtilTest : CoreTests {

    func testQueryMethod() {

        // test for nil
        let test_one_dict : [String:Any]? = nil
        assert(test_one_dict?.queryString() == nil)

        //test for one pair
        let test_two_dict : [String:Any] = ["key1":"value1"]
        assert(test_two_dict.queryString() == "key1=value1")

        //test for more pairs
        let test_three_dict : [String:Any] = ["key1":"value1", "key2":"value2"]
        print(test_three_dict.queryString())
        assert(test_three_dict.queryString() == "key2=value2&key1=value1")

        //test for more nested pairs
        let test_four_dict : [String:Any] = ["key1":"value1", "key2":["nkey2":"nvalue2"]]
        print(test_four_dict.queryString())
        assert(test_four_dict.queryString() == "key2=[\"nkey2\": \"nvalue2\"]&key1=value1")

    }

}
