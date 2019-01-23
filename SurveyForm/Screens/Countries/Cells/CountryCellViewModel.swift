//
//  CountryCellViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct CountryCellViewModel {
    let name: Dynamic<String>
    let code: String
    
    init(country: Country) {
        name = Dynamic(country.name)
        code = country.code
    }
}

// MARK: - Equatable
extension CountryCellViewModel: Equatable {
    static func ==(lhs: CountryCellViewModel, rhs: CountryCellViewModel) -> Bool {
        return lhs.code == rhs.code &&
            lhs.name.value == rhs.name.value
    }
}
