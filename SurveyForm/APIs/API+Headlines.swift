//
//  API+Headlines.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

extension APIManager {
    struct Headlines {
        private init() {}
        
        static func getTop(country: String, completion: @escaping (Network.Response) -> Void) {
            let url = APIManager.endpoint(path: Constant.StringURL.Headlines.getTop)
            let params: [String: Any] = [
                "country": country
            ]
            
            APIManager.request(method: .get, url: url, params: params, completion: completion)
        }
    }
}
