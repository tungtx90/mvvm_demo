//
//  NewSourceTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/22/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class NewSourceTests: XCTestCase {
    func testInit() {
        let id = "cnn"
        let name = "CNN"
        let source = NewSource(id: id, name: name)
        XCTAssert(source.id == id, "Source id should be \(id)")
        XCTAssert(source.name == name, "Source name should be \(name)")
    }
    
    func testInitFromData() {
        let id = "cnn"
        let name = "CNN"
        let string = """
        {
            "id": "\(id)",
            "name": "\(name)"
        }
        """
        let data = string.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let source = try decoder.decode(NewSource.self, from: data)
            XCTAssert(source.id == id, "Source id should be \(id)")
            XCTAssert(source.name == name, "Source name should be \(name)")
        } catch {
            XCTFail("Source should be created successfully | error = \(error.localizedDescription)")
        }
    }
}
