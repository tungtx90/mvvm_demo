//
//  FeedbackTextViewCell.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class FeedbackTextViewCell: UITableViewCell {
    @IBOutlet private weak var textView: UITextView!
    
    private weak var row: Form.Section.Row<String>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        guard selected else { return }
        textView.becomeFirstResponder()
    }
    
    func setup(row: Form.Section.Row<String>) {
        self.row = row
        textView.text = row.value
    }
}

// MARK: - UITextViewDelegate
extension FeedbackTextViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        row?.value = textView.text ?? ""
    }
}
