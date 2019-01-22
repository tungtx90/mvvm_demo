//
//  StringURL.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

extension Constant {
    struct StringURL {
        private init() {}
        
        static var root: String {
            switch environment {
            case .staging:
                return "https://newsapi.org"
            case .production:
                return "https://newsapi.org"
            }
        }
        
        static let apiKey = "cbcbd6968df941c8b2e00f4b4da9c48b"
        static let timeoutInterval: TimeInterval = 5.0
    }
}

// MARK: - Headlines
extension Constant.StringURL {
    struct Headlines {
        private init() {}
        
        static let getTop = "/v2/top-headlines"
    }
}
