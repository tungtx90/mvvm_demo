//
//  TableViewModel.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/21/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

protocol TableViewModel {
    associatedtype ViewModelType
    
    var numberOfSection: Int { get }
    func numberOfRow(inSection section: Int) -> Int
    func cellViewModel(at indexPath: IndexPath) -> ViewModelType?
}
