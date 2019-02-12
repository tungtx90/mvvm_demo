//
//  FeedbackViewController.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/11/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class FeedbackViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = FeedbackViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @objc private func doneItemTapped() {
        view.endEditing(true)
        
        let alert = UIAlertController(title: "Feedback", message: viewModel.alertContent, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.doneItemTitle, style: .done, target: self, action: #selector(doneItemTapped))
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: FeedbackTextViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FeedbackTextViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: FeedbackTextFieldCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FeedbackTextFieldCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension FeedbackViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.itemViewModel(at: indexPath) as? Form.Section.Row<String>,
            let rowType = FeedbackViewModel.RowType(rawValue: item.type)
        else {
            return UITableViewCell()
        }
        
        switch rowType {
        case .textField:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackTextFieldCell.reuseIdentifier, for: indexPath) as? FeedbackTextFieldCell
            else {
                return UITableViewCell()
            }
            cell.setup(row: item)
            return cell
        case .textView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackTextViewCell.reuseIdentifier, for: indexPath) as? FeedbackTextViewCell
            else {
                return UITableViewCell()
            }
            cell.setup(row: item)
            return cell
        }
        
    }
}
