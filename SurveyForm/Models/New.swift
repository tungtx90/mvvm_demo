//
//  New.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct New {
    let source: NewSource
    let author: String?
    let title: String
    let description: String?
    let urlString: String?
    let imageURLString: String?
    let publishedAt: Date
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case urlString = "url"
        case imageURLString = "urlToImage"
        case publishedAt
        case content
    }
}

// MARK: - Decodable
extension New: Decodable {}
