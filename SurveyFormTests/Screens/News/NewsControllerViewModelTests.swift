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
        let defaultValue = CountryCellViewModel(country: Country.default)
        XCTAssert(viewModel.country.value == defaultValue, "default country should be US")
    }
    
    func testCellViewModelNotFound() {
        let viewModel = NewsControllerViewModel()
        XCTAssert(viewModel.cellViewModel(at: IndexPath(row: 0, section: 0)) == nil, "cellViewModel should be nil")
    }
    
    func testAvailableNews() {
        let viewModel = NewsControllerViewModel()
        let expectation = XCTestExpectation(description: "testAvailableNews")
        
        viewModel.getTopHeadlines { (response) in
            switch response {
            case .failure(_):
                XCTFail("Request should be successful")
            case .success(_):
                XCTAssert(viewModel.numberOfSection == 1, "numberOfSection should be 1")
                XCTAssert(viewModel.numberOfRow(inSection: 1) > 0, "number of row in section 1 should be greater than 0")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
    
    func testEmptyNews() {
        let viewModel = NewsControllerViewModel()
        viewModel.country.value = CountryCellViewModel(country: Country(name: "abc", code: "aaa"))
        let expectation = XCTestExpectation(description: "testEmptyNews")
        
        viewModel.getTopHeadlines { (response) in
            switch response {
            case .failure(_):
                XCTFail("Request should be successful")
            case .success(_):
                XCTAssert(viewModel.numberOfSection == 1, "numberOfSection should be 1")
                XCTAssert(viewModel.numberOfRow(inSection: 1) == 0, "number of row in section 1 should be 0")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constant.timeoutInterval)
    }
}
