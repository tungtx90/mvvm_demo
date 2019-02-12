//
//  CountryViewController.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

protocol CountryViewControllerDelegate: class {
    func countryController(_ controller: CountryViewController, didSelectCountryCode countryCode: String)
}

final class CountryViewController: UIViewController {
    var viewModel: CountryControllerViewModel?
    weak var delegate: CountryViewControllerDelegate?
    
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Actions
    @objc private func doneItemTapped() {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let item = viewModel?.itemViewModel(at: indexPath)
        else { return }
        delegate?.countryController(self, didSelectCountryCode: item.code)
    }

    // MARK: - Private
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneItemTapped))
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    private func setupData() {
        guard let index = viewModel?.countryIndex else { return}
        tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
    }
}

// MARK: - UITableViewDataSource
extension CountryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRow(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell,
            let countryCellViewModel = viewModel?.itemViewModel(at: indexPath)
        else {
            return UITableViewCell()
        }
        cell.configure(viewModel: countryCellViewModel)
        return cell
    }
}
