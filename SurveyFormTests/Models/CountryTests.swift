//
//  CountryTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/22/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class CountryTests: XCTestCase {
    func testInit() {
        let name = "US"
        let code = "us"
        let country = Country(name: name, code: code)
        XCTAssert(country.name == name, "Country name should be \(name)")
        XCTAssert(country.code == code, "Country code should be \(code)")
    }
    
    func testDefaultCountry() {
        let country = Country.default
        let name = "US"
        let code = "us"
        XCTAssert(country.name == name, "Country name should be \(name)")
        XCTAssert(country.code == code, "Country code should be \(code)")
    }
    
    func testCountryFound() {
        XCTAssert(Country.find(code: "us") != nil, "Country should be found")
    }
    
    func testCountryNotFound() {
        XCTAssert(Country.find(code: "abc") == nil, "Country should be not found")
    }
}
