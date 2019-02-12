//
//  ReuseIdentifier.swift
//  SurveyForm
//
//  Created by Tung Tran on 2/12/19.
//  Copyright © 2019 tungtran. All rights reserved.
//

import Foundation
import UIKit

protocol ReuseableIdentifier {}

extension ReuseableIdentifier where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableIdentifier {}
extension UICollectionViewCell: ReuseableIdentifier {}
