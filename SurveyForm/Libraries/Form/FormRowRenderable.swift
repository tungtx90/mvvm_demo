//
//  FormRow.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

protocol RowRenderable: class {
    var id: String { get }
    var type: String { get }
}
