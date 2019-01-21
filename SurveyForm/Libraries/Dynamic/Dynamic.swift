//
//  Observable.swift
//  SurveyForm
//
//  Created by Tung Tran on 1/14/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    private var listeners: [Listener] = []
    var value: T {
        didSet {
            listeners.forEach { $0(value) }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
   func bind(_ listener: @escaping Listener) {
        listeners.append(listener)
    }
    
    func bindAndFire(_ listener: @escaping Listener) {
        listeners.append(listener)
        listener(value)
    }
}
