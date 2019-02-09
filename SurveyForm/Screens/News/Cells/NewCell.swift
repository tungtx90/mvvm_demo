//
//  NewCell.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class NewCell: UITableViewCell {
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configure(newCellViewModel: NewCellViewModel) {
        headerLabel.text = newCellViewModel.header.value
        bodyLabel.text = newCellViewModel.body.value
    }
}
