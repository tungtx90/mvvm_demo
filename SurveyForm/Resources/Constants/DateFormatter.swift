//
//  DateFormatter.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

extension Constant {
    struct DateFormatter {
        private init() {}
        
        static var iso8601: Foundation.DateFormatter {
            let dateFormatter = Foundation.DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter
        }
    }
}
