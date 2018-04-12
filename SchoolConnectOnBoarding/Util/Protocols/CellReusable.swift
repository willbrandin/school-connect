//
//  CellReusable.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit

protocol Injectable {
    associatedtype T
    func inject(_: T)
}

protocol ReusableView {}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol CellLoadableView: class {
    static var cellName: String { get }
}

extension CellLoadableView where Self: UIView {
    static var cellName: String {
        return String(describing: self)
    }
}
