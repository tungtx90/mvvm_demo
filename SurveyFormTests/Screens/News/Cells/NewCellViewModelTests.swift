//
//  NewCellViewModelTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/23/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class NewCellViewModelTests: XCTestCase {
    func testWithNew() {
        let new = New(source: NewSource(id: "id", name: "source_name"),
                      author: nil,
                      title: "new title",
                      description: "new description",
                      urlString: nil,
                      imageURLString: nil,
                      publishedAt: Date(),
                      content: "new content")
        let viewModel = NewCellViewModel(new: new)
        
        XCTAssert(viewModel.header.value == new.title, "header should be \(new.title)")
        XCTAssert(viewModel.body.value == new.description, "body should be \(new.description ?? "")")
    }
    
    func testDetailNewViewModel() {
        let new = New(source: NewSource(id: "id", name: "source_name"),
                      author: nil,
                      title: "new title",
                      description: "new description",
                      urlString: nil,
                      imageURLString: nil,
                      publishedAt: Date(),
                      content: "new content")
        let viewModel = NewCellViewModel(new: new)
        XCTAssert(viewModel.detailNewViewModel == DetailNewViewModel(new: new), "DetailNewViewModel should be same")
    }
}
