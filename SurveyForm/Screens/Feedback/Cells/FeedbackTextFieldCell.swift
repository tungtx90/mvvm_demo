//
//  FeedbackTextFieldCell.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class FeedbackTextFieldCell: UITableViewCell {
    @IBOutlet private weak var textField: UITextField!
    
    private weak var row: Form.Section.Row<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard selected else { return }
        textField.becomeFirstResponder()
    }
    
    func setup(row: Form.Section.Row<String>) {
        self.row = row
        textField.text = row.value
    }
    
    // MARK: - Private
    @objc private func textFieldDidChange() {
        row?.value = textField.text ?? ""
    }
}
