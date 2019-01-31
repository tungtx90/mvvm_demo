//
//  CountryControllerViewModelTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/23/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class CountryControllerViewModelTests: XCTestCase {
    func testSelectedCountryCode() {
        let countryCode = "country_code"
        let viewModel = CountryControllerViewModel(countryCode: countryCode)
        
        XCTAssert(viewModel.countryCode.value == countryCode, "countryCode should be \(countryCode) ")
    }
    
    func testNotFoundItem() {
        let item = CountryControllerViewModel(countryCode: "abc")
        XCTAssert(item.countryIndex == nil, "Index should be nil")
    }
    
    func testItemFound() {
        let item = CountryControllerViewModel(countryCode: "us")
        XCTAssert(item.countryIndex != nil, "Index should be not nil")
    }
    
    func testTableViewModel() {
        let viewModel = CountryControllerViewModel(countryCode: "us")
        XCTAssert(viewModel.numberOfSection == 1, "numberOfSection should be 1")
        XCTAssert(viewModel.numberOfRow(inSection: 0) == 3 , "numberOfRow in section 0 should be 3")
        
        let cellViewModel = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        XCTAssert(cellViewModel?.code == "de" && cellViewModel?.name.value == "Germany", "cellViewModel should be Germany")
        
        XCTAssert(viewModel.cellViewModel(at: IndexPath(row: 6, section: 0)) == nil, "cellViewModel should be nil")
    }
}
