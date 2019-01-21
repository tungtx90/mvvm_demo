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
    
    private var viewModel: NewCellViewModel? {
        didSet {
            viewModel?.header.bindAndFire { [weak self] in
                self?.headerLabel.text = $0
            }
            
            viewModel?.body.bindAndFire { [weak self] in
                self?.bodyLabel.text = $0
            }
        }
    }
    
    func configure(newCellViewModel: NewCellViewModel) {
        viewModel = newCellViewModel
    }
}
