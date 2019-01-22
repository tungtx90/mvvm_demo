//
//  NewSource.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct NewSource {
    let id: String?
    let name: String
}

// MARK: - Decodable
extension NewSource: Decodable {}

// MARK: - Equatable
extension NewSource: Equatable {
    static func ==(lhs: NewSource, rhs: NewSource) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}
