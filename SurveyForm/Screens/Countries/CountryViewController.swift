//
//  CountryViewController.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

protocol CountryViewControllerDelegate: class {
    func countryController(_ controller: CountryViewController, didSelectCountry country: CountryCellViewModel)
}

final class CountryViewController: UIViewController {
    var countryCellViewModel: CountryCellViewModel?
    weak var delegate: CountryViewControllerDelegate?
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: CountryControllerViewModel? {
        didSet {
            tableView.reloadData()
            
            viewModel?.selectedCountry.bindAndFire { [weak self] (_) in
                guard let country = self?.viewModel?.selectedCountry.value,
                    let index = self?.viewModel?.index(of: country)
                else {
                    return
                }
                
                self?.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
            }
        }
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Actions
    @objc private func doneItemTapped() {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let item = viewModel?.cellViewModel(at: indexPath)
        else { return }
        delegate?.countryController(self, didSelectCountry: item)
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
        viewModel = CountryControllerViewModel(country: countryCellViewModel)
    }
}

// MARK: - UITableViewDataSource
extension CountryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRow(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell,
            let countryCellViewModel = viewModel?.cellViewModel(at: indexPath)
        else {
            return UITableViewCell()
        }
        cell.configure(viewModel: countryCellViewModel)
        return cell
    }
}
