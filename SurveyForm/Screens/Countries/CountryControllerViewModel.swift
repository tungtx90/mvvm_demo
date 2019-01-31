//
//  CountryControllerViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct CountryControllerViewModel {
    private let countries: [CountryCellViewModel] = Constant.countries.map { CountryCellViewModel(country: $0) }

    var countryCode: Dynamic<String>
    var countryIndex: Int? {
        return countries.firstIndex { $0.code == countryCode.value }
    }
    
    init(countryCode: String) {
        self.countryCode = Dynamic(countryCode)
    }
}

// MARK: - TableView
extension CountryControllerViewModel: TableViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRow(inSection section: Int) -> Int {
        return countries.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CountryCellViewModel? {
        guard (0..<countries.count).contains(indexPath.row) else { return nil }
        return countries[indexPath.row]
    }
}
