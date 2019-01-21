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
}
