//
//  APIHeadlinesTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/22/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest

@testable import SurveyForm

class APIHeadlinesTests: XCTestCase {
    func testMissingCountryParamResponse() {
        let expectation = XCTestExpectation(description: "testMissingCountryParamResponse")
        
        APIManager.Headlines.getTop(country: "") { (response) in
            switch response.result {
            case .failure(_):
                break
            case .success(_):
                XCTFail("Request should be failed")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
    
    func testValidResponse() {
        let expectation = XCTestExpectation(description: "testValidResponse")
        
        APIManager.Headlines.getTop(country: "us") { (response) in
            switch response.result {
            case .failure(_):
                XCTFail("Request should be successful")
            case .success(_):
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
}
