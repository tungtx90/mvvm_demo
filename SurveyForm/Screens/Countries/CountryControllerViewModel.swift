//
//  CountryControllerViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct CountryControllerViewModel {
    private let countries: [CountryCellViewModel] = [
        Country.default,
        Country(name: "Germany", code: "de"),
        Country(name: "Japan", code: "jp")
    ].map { CountryCellViewModel(country: $0) }
    
    var selectedCountry: Dynamic<CountryCellViewModel?>
    
    init(country: CountryCellViewModel?) {
        selectedCountry = Dynamic(country)
    }
    
    func index(of item: CountryCellViewModel) -> Int? {
        return countries.firstIndex { item.name.value == $0.name.value }
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
