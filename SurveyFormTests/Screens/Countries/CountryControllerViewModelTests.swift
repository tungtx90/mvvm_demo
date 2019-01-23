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
    func testSelectedCountry() {
        let cellViewModel = CountryCellViewModel(country:  Country(name: "country_name", code: "country_code"))
        let viewModel = CountryControllerViewModel(country: cellViewModel)
        
        XCTAssert(viewModel.selectedCountry.value == cellViewModel, "selectedCountry should be \(cellViewModel) ")
    }
    
    func testNilSelectedCountry() {
        let viewModel = CountryControllerViewModel(country: nil)
        
        XCTAssert(viewModel.selectedCountry.value == nil, "selectedCountry should be nil")
    }
    
    func testNotFoundItem() {
        let item = CountryCellViewModel(country: Country(name: "abc", code: "aaa"))
        let index = CountryControllerViewModel(country: nil).index(of: item)
        
        XCTAssert(index == nil, "Index should be nil")
    }
    
    func testItemFound() {
        let item = CountryCellViewModel(country: Country(name: "US", code: "us"))
        let index = CountryControllerViewModel(country: nil).index(of: item)
        
        XCTAssert(index != nil, "Index should be not nil")
    }
    
    func testTableViewModel() {
        let viewModel = CountryControllerViewModel(country: nil)
        XCTAssert(viewModel.numberOfSection == 1, "numberOfSection should be 1")
        XCTAssert(viewModel.numberOfRow(inSection: 0) == 3 , "numberOfRow in section 0 should be 3")
        
        let cellViewModel = viewModel.cellViewModel(at: IndexPath(row: 1, section: 0))
        XCTAssert(cellViewModel?.code == "de" && cellViewModel?.name.value == "Germany", "cellViewModel should be Germany")
        
        XCTAssert(viewModel.cellViewModel(at: IndexPath(row: 6, section: 0)) == nil, "cellViewModel should be nil")
    }
}
