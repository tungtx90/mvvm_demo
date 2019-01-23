//
//  CountryCellViewModelTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/23/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class CountryCellViewModelTests: XCTestCase {
    func testWithCountry() {
        let country = Country(name: "ABCD", code: "a12")
        let viewModel = CountryCellViewModel(country: country)
        
        XCTAssert(viewModel.code == country.code, "code should be \(country.code)")
        XCTAssert(viewModel.name.value == country.name, "name should be \(country.name)")
    }
}
