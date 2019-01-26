//
//  Resutl.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/26/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import Foundation

enum Result<T,U> {
    case success(T)
    case error(U)
}
