//
//  HeadlinesManagerTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/22/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest

@testable import SurveyForm

class HeadlinesManagerTests: XCTestCase {
    func testEmptyResponse() {
        let expectation = XCTestExpectation(description: "testEmptyResponse")
        
        HeadlinesManager.getTop(country: "abc") { (response) in
            switch response {
            case .failure(_):
                XCTFail("Request should be successful")
            case .success(let news):
                XCTAssert(news.isEmpty, "Result should be empty")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
    
    func testValidResponse() {
        let expectation = XCTestExpectation(description: "testValidResponse")
        
        HeadlinesManager.getTop(country: "us") { (response) in
            switch response {
            case .failure(_):
                XCTFail("Request should be successful")
            case .success(let news):
                XCTAssert(!news.isEmpty, "Result should not be empty")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
}
