//
//  FeedbackViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct FeedbackViewModel {
    enum SectionID: String, CaseIterable {
        case subject
        case description
        
        var title: String {
            switch self {
            case .subject:
                return "Subject"
            case .description:
                return "Description"
            }
        }
    }
    enum RowID: String , CaseIterable {
        case subject
        case description
    }
    enum RowType: String, CaseIterable {
        case textField
        case textView
    }
    
    let doneItemTitle = "Done"
    
    var isValidData: Bool {
        for section in form.sections {
            for row in section.rows {
                let value = (row as? Form.Section.Row<String>)?.value.trimmingCharacters(in: .whitespacesAndNewlines)
                if value?.isEmpty == true {
                    return false
                }
            }
        }
        return true
    }
    
    var alertContent: String {
        if !isValidData {
            return "Please enter feedback!"
        }
        
        var content: [String] = []
        for section in form.sections {
            for row in section.rows {
                guard let value = (row as? Form.Section.Row<String>)?.value.trimmingCharacters(in: .whitespacesAndNewlines) else {
                    break
                }
                content.append(value)
            }
        }
        return content.joined(separator: "\n")
    }
    
    private let form = Form(sections: [])
    
    init() {
        let sections = [
            Form.Section(id: SectionID.subject.rawValue, title: SectionID.subject.title, rows: [
                Form.Section.Row(id: RowID.subject.rawValue, type: RowType.textField.rawValue, title: nil, value: "")
            ]),
            Form.Section(id: SectionID.description.rawValue, title: SectionID.description.title, rows: [
                Form.Section.Row(id: RowID.description.rawValue, type: RowType.textView.rawValue, title: nil, value: "")
            ])
        ]
        form.sections = sections
    }
}

extension FeedbackViewModel: TableViewModel {
    var numberOfSection: Int {
        return form.sections.count
    }
    
    func numberOfRow(inSection section: Int) -> Int {
        return form.sections[section].rows.count
    }
    
    func itemViewModel(at indexPath: IndexPath) -> RowRenderable? {
        return form.sections[indexPath.section].rows[indexPath.row]
    }
    
    func titleForHeader(inSection section: Int) -> String? {
        return (form.sections[section] as? Form.Section)?.title
    }
}
