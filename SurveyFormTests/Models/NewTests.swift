//
//  NewTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 1/22/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class NewTests: XCTestCase {
    func testInit() {
        let source = NewSource(id: "cnn", name: "CNN")
        let author = "Joshua Berlinger, CNN"
        let title = "The only thing we can do"
        let description = "Climate change is causing Greenland's massive ice sheets"
        let date = Date()
        let urlString = "https://www.cnn.com/2019/01/21/health/greenland-ice-melt-study-intl/index.html"
        let imageURLString = "https://cdn.cnn.com/cnnnext/dam/assets/181116173151-ocean-warming-super-tease.jpg"
        let content = "(CNN) Climate change is causing Greenland's massive ice sheets to melt much faster"
        let new = New(source: source,
                      author: author,
                      title: title,
                      description: description,
                      urlString: urlString,
                      imageURLString: imageURLString,
                      publishedAt: date,
                      content: content)
        
        XCTAssert(new.source == source, "New source should be \(source)")
        XCTAssert(new.author == author, "New source author should be '\(author)'")
        XCTAssert(new.title == title, "New source title should be '\(title)'")
        XCTAssert(new.description == description, "New source description should be '\(description)'")
        XCTAssert(new.urlString == urlString, "New source urlString should be '\(urlString)'")
        XCTAssert(new.imageURLString == imageURLString, "New source imageURLString should be '\(imageURLString)'")
        XCTAssert(new.content == content, "New source content should be '\(content)'")
        XCTAssert(new.publishedAt == date, "New source date should be '\(date)'")
    }
    
    func testInitFromStringData() {
        let source = NewSource(id: "cnn", name: "CNN")
        let author = "Joshua Berlinger, CNN"
        let title = """
        'The only thing we can do is adapt': Greenland ice melt reaches 'tipping point,' study finds - CNN
        """
        let description = """
        Climate change is causing Greenland's massive ice sheets to melt much faster than previously thought, \
        a new study has found, and it may be 'too late' to do anything about it.
        """
        let url = "https://www.cnn.com/2019/01/21/health/greenland-ice-melt-study-intl/index.html"
        let urlToImage = "https://cdn.cnn.com/cnnnext/dam/assets/181116173151-ocean-warming-super-tease.jpg"
        let publishedAt = "2019-01-22T02:56:00Z"
        let content = """
        (CNN) Climate change is causing Greenland's massive ice sheets to melt much faster than previously thought, \
        a new study has found, and it may be 'too late' to do anything about it. The findings could have dire implications for the planet's low lying islands a… [+2569 chars]
        """
        let string = """
        {
            "source": {
                "id": "\(source.id!)",
                "name": "\(source.name)"
            },
            "author": "\(author)",
            "title": "\(title)",
            "description": "\(description)",
            "url": "\(url)",
            "urlToImage": "\(urlToImage)",
            "publishedAt": "\(publishedAt)",
            "content": "\(content)"
        }
        """

        let data = string.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Constant.DateFormatter.iso8601)
        do {
            let new = try decoder.decode(New.self, from: data)
            XCTAssert(new.source == source, "New source should be \(source)")
            XCTAssert(new.author == author, "New source author should be \(author)")
            XCTAssert(new.title == title, "New source title should be \(title)")
            XCTAssert(new.description == description, "New source description should be \(description)")
            XCTAssert(new.urlString == url, "New source urlString should be \(url)")
            XCTAssert(new.imageURLString == urlToImage, "New source imageURLString should be \(urlToImage)")
            XCTAssert(new.publishedAt.compare(Constant.DateFormatter.iso8601.date(from: publishedAt) ?? Date()) == .orderedSame,
                      "New source publishedAt should be \(publishedAt)")
            XCTAssert(new.content == content, "New source content should be \(content)")
        } catch {
            XCTFail("New should be created successfully | error = \(error.localizedDescription)")
        }
    }
}
