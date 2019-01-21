//
//  CountryTableViewCell.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class CountryTableViewCell: UITableViewCell {
    @IBOutlet private weak var countryLabel: UILabel!
    
    private var viewModel: CountryCellViewModel? {
        didSet {
            viewModel?.name.bindAndFire { [weak self] in
                self?.countryLabel.text = $0
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
    
    func configure(viewModel: CountryCellViewModel) {
        self.viewModel = viewModel
    }
}
