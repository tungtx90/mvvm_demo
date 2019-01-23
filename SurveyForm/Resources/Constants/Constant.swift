//
//  Constant.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct Constant {
    private init() {}
    
    enum Environment {
        case staging
        case production
    }
    
    static let environment: Environment = .staging
    static let apiKey = "cbcbd6968df941c8b2e00f4b4da9c48b"
    static let timeoutInterval: TimeInterval = 5.0
}
