//
//  Country.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct Country {
    let name: String
    let code: String
    
    static let `default` = Country(name: "US", code: "us")
    
    static func find(code: String) -> Country? {
        return Constant.countries.first { $0.code == code }
    }
}
