//
//  Form.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

final class Form: FormRenderable {
    var sections: [SectionRenderable]
    
    init(sections: [SectionRenderable]) {
        self.sections = sections
    }
}

extension Form {
    final class Section: SectionRenderable {
        let id: String
        var title: String?
        var rows: [RowRenderable]
        
        init(id: String, title: String? = nil, rows: [RowRenderable]) {
            self.id = id
            self.title = title
            self.rows = rows
        }
    }
}

extension Form.Section {
    final class Row<ValueType>: RowRenderable {
        let id: String
        let type: String
        let title: String?
        var value: ValueType
        
        init(id: String, type: String = "", title: String? = nil, value: ValueType) {
            self.id = id
            self.type = type
            self.title = title
            self.value = value
        }
    }
}
