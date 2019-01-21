//
//  HeadlinesManager.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct HeadlinesManager {
    private init() {}
}

// MARK: - Top Headline
extension HeadlinesManager {
    private struct TopHeadlinesResponse: Decodable {
        let articles: [New]
    }
    
    static func getTop(country: String, completion: @escaping (APIManager.Response<[New]>) -> Void) {
        APIManager.Headlines.getTop(country: country) { (response) in
            switch response.result {
            case .failure(let error):
                completion(APIManager.Response<[New]>.failure(error: error))
            case .success(let value):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Constant.DateFormatter.iso8601)
                do {
                    let topHeadlinesResponse = try decoder.decode(TopHeadlinesResponse.self, from: value)
                    completion(APIManager.Response<[New]>.success(value: topHeadlinesResponse.articles))
                } catch {
                    completion(APIManager.Response<[New]>.failure(error: error as NSError))
                }
            }
        }
    }
}
