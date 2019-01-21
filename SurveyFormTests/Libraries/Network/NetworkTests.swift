//
//  NetworkTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/18/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest

@testable import SurveyForm

class NetworkTests: XCTestCase {
    func testSuccessfulResponse() {
        let url = Constant.StringURL.root + Constant.StringURL.Headlines.getTop
        let params: [String: Any] = [
            "apiKey": Constant.StringURL.apiKey,
            "country": "us"
        ]
        Network.request(method: .get, url: url, params: params) { (response) in
            print("response status = \(response.response?.statusCode ?? 0)")
            XCTAssert(response.response?.statusCode == 300, "Response should be success")
        }
    }
    
    func testFailedResponse() {
        let url = Constant.StringURL.root + "/test"
        let params: [String: Any] = [
            "apiKey": Constant.StringURL.apiKey
        ]
        Network.request(method: .get, url: url, params: params) { (response) in
            XCTAssert(response.response?.statusCode != 200, "Response should be failed")
        }
    }
}
