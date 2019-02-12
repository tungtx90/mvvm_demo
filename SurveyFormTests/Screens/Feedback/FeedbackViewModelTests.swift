//
//  FeedbackViewModelTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class FeedbackViewModelTests: XCTestCase {

    func testSetup() {
        let viewModel = FeedbackViewModel()
        
        XCTAssert(viewModel.doneItemTitle == "Done", "Done button title should be Done")
        
        XCTAssert(viewModel.numberOfSection == 2, "Number of section should be 2")
        XCTAssert(viewModel.numberOfRow(inSection: 0) == 1, "Number of row in section 0 should be 1")
        XCTAssert(viewModel.numberOfRow(inSection: 1) == 1, "Number of row in section 1 should be 1")
        
        let subjectRow = viewModel.itemViewModel(at: IndexPath(row: 0, section: 0)) as? Form.Section.Row<String>
        XCTAssert(viewModel.titleForHeader(inSection: 0) == "Subject", "section 0 title should be Subject")
        XCTAssert(subjectRow?.value.isEmpty == true, "Row 0 in section 0 value should be empty")
        
        let descriptionRow = viewModel.itemViewModel(at: IndexPath(row: 0, section: 1)) as? Form.Section.Row<String>
        XCTAssert(viewModel.titleForHeader(inSection: 1) == "Description", "section 1 title should be Description")
        XCTAssert(descriptionRow?.value.isEmpty == true, "Row 0 in section 1 value should be empty")
    }
    
    func testValidData() {
        let viewModel = FeedbackViewModel()
        let subjectRow = viewModel.itemViewModel(at: IndexPath(row: 0, section: 0)) as? Form.Section.Row<String>
        subjectRow?.value = "123"
        XCTAssert(subjectRow?.value.isEmpty == false, "Subject should not be empty")
        
        let descriptionRow = viewModel.itemViewModel(at: IndexPath(row: 0, section: 1)) as? Form.Section.Row<String>
        descriptionRow?.value = "abcdedf"
        XCTAssert(descriptionRow?.value.isEmpty == false, "Description should not be empty")
        
        XCTAssert(viewModel.isValidData == true, "Data should be valid")
        
        let content = "\(subjectRow?.value ?? "")\n\(descriptionRow?.value ?? "")"
        XCTAssert(viewModel.alertContent == content, "Content should be \(content)")
    }
    
    func testInvalidDataAlert() {
        let viewModel = FeedbackViewModel()
        let alert = "Please enter feedback!"
        XCTAssert(viewModel.alertContent == alert, "Alert should be \(alert)")
    }
}
