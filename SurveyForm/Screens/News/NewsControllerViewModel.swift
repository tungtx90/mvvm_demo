//
//  NewsControllerViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

final class NewsControllerViewModel {
    private var newCellViewModels: [NewCellViewModel] = []
    var country = Dynamic<CountryCellViewModel?>(CountryCellViewModel(country: Country.default))
}

// MARK: - TableViewModel
extension NewsControllerViewModel: TableViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRow(in section: Int) -> Int {
        return newCellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> NewCellViewModel {
        return newCellViewModels[indexPath.row]
    }
}

// MARK: - API
extension NewsControllerViewModel {
    func getTopHeadlines(completion: @escaping (APIManager.Response<Bool>) -> Void) {
        guard let country = country.value?.code else {
            completion(APIManager.Response.failure(error: NSError.error(message: "Country not found!")))
            return
        }
        HeadlinesManager.getTop(country: country) { (response) in
            switch response {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(APIManager.Response<Bool>.failure(error: error))
                }
            case .success(let value):
                self.newCellViewModels = value.map { NewCellViewModel(new: $0) }
                DispatchQueue.main.async {
                    completion(APIManager.Response<Bool>.success(value: true))
                }
            }
        }
    }
}
