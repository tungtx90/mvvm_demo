//
//  DetailNewViewModelTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/23/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class DetailNewViewModelTests: XCTestCase {
    func testWithNew() {
        let new = New(source: NewSource(id: "id", name: "source_name"),
                      author: nil,
                      title: "new title",
                      description: nil,
                      urlString: nil,
                      imageURLString: nil,
                      publishedAt: Date(),
                      content: "new content")
        let viewModel = DetailNewViewModel(new: new)
        
        XCTAssert(viewModel.content == new.content, "ViewModel content should be \(new.content ?? "")")
        XCTAssert(viewModel.header == new.title, "ViewModel header should be \(new.title)")
    }
}
