//
//  NewCellViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/15/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

struct NewCellViewModel {
    var header: Dynamic<String>
    var body: Dynamic<String>
    
    var detailNewViewModel: DetailNewViewModel {
        return DetailNewViewModel(new: new)
    }
    
    private let new: New
    
    init(new: New) {
        header = Dynamic<String>(new.title)
        body = Dynamic<String>(new.description ?? "")
        self.new = new
    }
}
