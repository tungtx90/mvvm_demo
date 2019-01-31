//
//  DetailNewViewController.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/16/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class DetailNewViewController: UIViewController {
    var viewModel: DetailNewViewModel?
    
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var contentTextView: UITextView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    private func setupUI() {
        guard let detailNewViewModel = viewModel else { return }
        headerLabel.text = detailNewViewModel.header
        contentTextView.text = detailNewViewModel.content
    }
}
