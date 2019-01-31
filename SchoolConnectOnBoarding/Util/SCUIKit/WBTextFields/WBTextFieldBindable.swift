//
//  WBTextFieldBindable.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/25/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import Foundation

protocol WBTextFieldBindable: class {
    var onTextChanged: ((String) -> Void)? { get set }
}
