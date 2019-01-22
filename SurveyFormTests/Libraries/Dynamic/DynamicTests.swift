//
//  DynamicTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/22/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest

@testable import SurveyForm

class DynamicTests: XCTestCase {
    func testInitValue() {
        let num = 10
        let dynamicNum = Dynamic(num)
        XCTAssert(dynamicNum.value == num, "dynamicNum value should be 10")
    }
    
    func testBindValue() {
        let expectation = XCTestExpectation(description: "testBindValue")
        let num = Dynamic(10)
        num.bind { (value) in
            XCTAssert(value == num.value, "num value should be 200")
            expectation.fulfill()
        }
        num.value = 200
        wait(for: [expectation], timeout: 2)
    }
    
    func testBindAndFireValue() {
        let expectation = XCTestExpectation(description: "testBindAndFireValue")
        let num = Dynamic(10)
        num.bindAndFire { (value) in
            XCTAssert(value == num.value, "num value should be 10")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
}
