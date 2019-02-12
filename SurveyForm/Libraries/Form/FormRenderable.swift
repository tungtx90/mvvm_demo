//
//  Form.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/11/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

protocol FormRenderable: class {
    var sections: [SectionRenderable] { get set }
}

extension FormRenderable {
    func section(byID id: String) -> SectionRenderable? {
        return sections.first { $0.id == id }
    }
    
    func row(byID id: String) -> RowRenderable? {
        for section in sections {
            if let row = section.row(byID: id) {
                return row
            }
        }
        return nil
    }
    
    func indexPath(ofRowID rowID: String) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            if let index = section.rows.index(where: { $0.id == rowID }) {
                return IndexPath(row: index, section: sectionIndex)
            }
        }
        return nil
    }
}
