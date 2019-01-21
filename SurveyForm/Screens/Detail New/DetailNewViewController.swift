//
//  DetailNewViewController.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/16/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class DetailNewViewController: UIViewController {
    var newCellViewModel: NewCellViewModel?
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var contentTextView: UITextView!
    private var detailNewViewModel: DetailNewViewModel? {
        didSet {
            fillData()
        }
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    // MARK: - Private
    private func setupData() {
        detailNewViewModel = newCellViewModel?.detailNewViewModel
    }
    
    private func fillData() {
        guard let detailNewViewModel = detailNewViewModel else { return }
        headerLabel.text = detailNewViewModel.header
        contentTextView.text = detailNewViewModel.content
    }
}
