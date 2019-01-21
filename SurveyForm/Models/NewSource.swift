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
