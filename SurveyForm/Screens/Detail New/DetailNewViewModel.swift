//
//  DetailNewViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/16/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct DetailNewViewModel {
    let header: String
    let content: String
    
    init(new: New) {
        header = new.title
        content = new.content ?? ""
    }
}
