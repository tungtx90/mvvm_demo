//
//  NewsViewController.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/14/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import UIKit

final class NewsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private enum SegueID: String {
        case toDetailNew = "NewToDetailSegue"
        case toCountry = "NewToCountrySegue"
    }
    
    private let viewModel = NewsControllerViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        fetchNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = SegueID(rawValue: segue.identifier ?? "") else { return }
        switch segueID {
        case .toDetailNew:
            guard let detailNewViewController = segue.destination as? DetailNewViewController,
                let indexPath = tableView.indexPathForSelectedRow
            else { return }
            detailNewViewController.viewModel = viewModel.cellViewModel(at: indexPath)?.detailNewViewModel
        case .toCountry:
            guard let countryViewController = segue.destination as? CountryViewController else { return }
            countryViewController.viewModel = CountryControllerViewModel(countryCode: viewModel.countryCode.value)
            countryViewController.delegate = self
        }
    }
    
    // MARK: - Actions
    @objc private func countryItemTapped() {
        performSegue(withIdentifier: SegueID.toCountry.rawValue, sender: self)
    }
    
    // MARK: - Private
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        guard let country = Country.find(code: viewModel.countryCode.value) else { return }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: country.name, style: .plain, target: self, action: #selector(countryItemTapped))
    }
    
    private func setupBinding() {
        viewModel.countryCode.bind { [weak self] (_) in
            self?.setupNavigationBar()
            self?.fetchNews()
        }
        viewModel.isLoading.bind { [weak self] (isLoading) in
            guard let strongSelf = self else { return }
            if !isLoading {
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
    
    private func fetchNews() {
        viewModel.getTopHeadlines { (result) in
            switch result {
            case .failure(let error):
                print("Error = \(error)")
            default: return
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewCell,
            let cellViewModel = viewModel.cellViewModel(at: indexPath)
        else {
            return UITableViewCell()
        }
        
        cell.configure(newCellViewModel: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CountryControllerDelegate
extension NewsViewController: CountryViewControllerDelegate {
    func countryController(_ controller: CountryViewController, didSelectCountryCode countryCode: String) {
        navigationController?.popViewController(animated: true)
        viewModel.countryCode.value = countryCode
    }
}
