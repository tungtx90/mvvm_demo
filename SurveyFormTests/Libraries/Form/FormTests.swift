//
//  FormTests.swift
//  SurveyFormTests
//
//  Created by Tung Tran on 2/11/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import XCTest
@testable import SurveyForm

class FormTests: XCTestCase {
    func testSetupRow() {
        let id = "row_id"
        let title = "row_title"
        let value = 100
        let row = Form.Section.Row(id: id, title: title, value: value)
        
        XCTAssert(row.id == id, "Row id should be \(id)")
        XCTAssert(row.title == title, "Row id should be \(title)")
        XCTAssert(row.value == value, "Row value should be \(value)")
    }
    
    func testSetupSection() {
        let id = "section_id"
        let title = "title"
        let rows = [
            Form.Section.Row(id: "id", title: "title", value: 200)
        ]
        let section = Form.Section(id: id, title: title, rows: rows)
        
        XCTAssert(section.id == id, "Section id should be \(id)")
        XCTAssert(section.title == title, "Section title should be \(title)")
        XCTAssert(section.rows.count == rows.count, "Section rows should be \(rows.description)")
        XCTAssert(section.rows.first?.id == rows.first?.id, "Section rows should be \(rows.description)")
    }
    
    func testSectionRowFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        
        XCTAssert(section.row(byID: row.id)?.id == row.id, "Row should be found")
    }
    
    func testSectionRowNotFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        
        XCTAssert(section.row(byID: "id111") == nil, "Row should be not found")
    }
    
    func testSetupForm() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.sections.count == sections.count, "Form sections should be the same")
        XCTAssert(form.sections.first?.id == sections.first?.id, "Form sections should be the same")
    }
    
    func testSectionFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.section(byID: section.id)?.id == section.id, "Form section should be found")
    }
    
    func testSectionNotFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.section(byID: "aaaa")?.id == nil, "Form section should be not found")
    }
    
    func testFormRowFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.row(byID: row.id)?.id == row.id, "Form section should be found")
    }
    
    func testFormRowNotFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.row(byID: "1232")?.id == nil, "Form section should be not found")
    }
    
    func testFormRowIndexPathFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.indexPath(ofRowID: row.id) == IndexPath(row: 0, section: 0), "Indexpath should be found")
    }
    
    func testFormRowIndexPathNotFound() {
        let row = Form.Section.Row(id: "id", title: "title", value: 200)
        let section = Form.Section(id: "section_id", title: "title", rows: [row])
        let sections = [section]
        let form = Form(sections: sections)
        
        XCTAssert(form.indexPath(ofRowID: "row.id") == nil, "Indexpath should be not found")
    }
}
