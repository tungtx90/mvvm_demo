//
//  NewsControllerViewModelTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/23/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class NewsControllerViewModelTests: XCTestCase {
    func testWithDefaultCountry() {
        let viewModel = NewsControllerViewModel()
        let defaultValue = Country.default
        XCTAssert(viewModel.countryCode.value == defaultValue.code, "default country should be US")
    }
    
    func testFeedbackItemTitle() {
        let viewModel = NewsControllerViewModel()
        XCTAssert(viewModel.feedbackItemTitle == "Feedback", "feedback title should be Feedback")
    }
    
    func testCellViewModelNotFound() {
        let viewModel = NewsControllerViewModel()
        XCTAssert(viewModel.itemViewModel(at: IndexPath(row: 0, section: 0)) == nil, "cellViewModel should be nil")
    }
    
    func testAvailableNews() {
        let viewModel = NewsControllerViewModel()
        let expectation = XCTestExpectation(description: "testAvailableNews")
        
        viewModel.showError = { (_) in
            XCTFail("Request should be successful")
            expectation.fulfill()
        }
        viewModel.finishLoading = {
            XCTAssert(viewModel.numberOfSection == 1, "numberOfSection should be 1")
            XCTAssert(viewModel.numberOfRow(inSection: 1) > 0, "number of row in section 1 should be greater than 0")
            expectation.fulfill()
        }
        viewModel.getTopHeadlines()
        
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
    
    func testEmptyNews() {
        let viewModel = NewsControllerViewModel()
        viewModel.countryCode.value = "aaa"
        let expectation = XCTestExpectation(description: "testEmptyNews")
        
        viewModel.showError = { (_) in
            XCTFail("Request should be successful")
            expectation.fulfill()
        }
        viewModel.finishLoading = {
            XCTAssert(viewModel.numberOfSection == 1, "numberOfSection should be 1")
            XCTAssert(viewModel.numberOfRow(inSection: 1) == 0, "number of row in section 1 should be 0")
            expectation.fulfill()
        }
        viewModel.getTopHeadlines()
        
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
}
