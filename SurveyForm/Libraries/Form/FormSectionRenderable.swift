//
//  FormSection.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

protocol SectionRenderable: class {
    var id: String { get }
    var rows: [RowRenderable] { get set }
}

extension SectionRenderable {    
    func row(byID id: String) -> RowRenderable? {
        return rows.first { $0.id == id }
    }
}
