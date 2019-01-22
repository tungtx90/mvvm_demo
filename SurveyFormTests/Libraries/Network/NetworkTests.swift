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
        let expectation = XCTestExpectation(description: "testSuccessfulResponse")
        let url = Constant.StringURL.root + Constant.StringURL.Headlines.getTop
        let params: [String: Any] = [
            "apiKey": Constant.StringURL.apiKey,
            "country": "us"
        ]
        
        Network.request(method: .get, url: url, params: params) { (response) in
            XCTAssert(response.response?.statusCode == 200, "Response should be success")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testFailedResponse() {
        let expectation = XCTestExpectation(description: "testFailedResponse")
        let url = Constant.StringURL.root + "/test"
        let params: [String: Any] = [
            "apiKey": Constant.StringURL.apiKey
        ]
        
        Network.request(method: .get, url: url, params: params) { (response) in
            XCTAssert(response.response?.statusCode != 200, "Response should be failed")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testCancelingResponse() {
        let url = Constant.StringURL.root + Constant.StringURL.Headlines.getTop
        let params: [String: Any] = [
            "apiKey": Constant.StringURL.apiKey,
            "country": "us"
        ]
        
        let task = Network.request(method: .get, url: url, params: params) { (_) in }
        if task?.state == URLSessionTask.State.running {
            task?.cancel()
            XCTAssert(task?.state == URLSessionTask.State.canceling, "Response should be canceled")
        }
    }
}
