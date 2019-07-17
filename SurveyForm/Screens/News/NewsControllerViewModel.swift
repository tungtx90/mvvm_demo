//
//  NewsControllerViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

final class NewsControllerViewModel {
    let feedbackItemTitle = "Feedback"
    
    var countryCode = Dynamic(Country.default.code)
    var countryName: String? {
        return Country.find(code: countryCode.value)?.name
    }
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var finishLoading: (() -> Void)?
    var showError: ((NSError) -> Void)?
    
    private var newCellViewModels: [NewCellViewModel] = []
}

// MARK: - TableViewModel
extension NewsControllerViewModel: TableViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRow(inSection section: Int) -> Int {
        return newCellViewModels.count
    }
    
    func itemViewModel(at indexPath: IndexPath) -> NewCellViewModel? {
        guard (0..<newCellViewModels.count).contains(indexPath.row) else { return nil }
        return newCellViewModels[indexPath.row]
    }
}

// MARK: - API
extension NewsControllerViewModel {
    func getTopHeadlines() {
        showLoading?()
        HeadlinesManager.getTop(country: countryCode.value) { (response) in
            self.hideLoading?()
            switch response {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error)
                    self.finishLoading?()
                }
            case .success(let value):
                self.newCellViewModels = value.map { NewCellViewModel(new: $0) }
                DispatchQueue.main.async {
                    self.finishLoading?()
                }
            }
        }
    }
}
