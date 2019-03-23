//
//  SchoolColorable.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit

protocol SchoolColorable {
    var schoolPrimaryColor: UIColor? { get }
    var schoolSecondaryColor: UIColor? { get }
}

extension SchoolColorable {
    
    var schoolPrimaryColor: UIColor? {
//        return SCDatabaseQueryManager.getSavedPrimaryColor()
        return SCColors.scGreen
    }
    
    var schoolSecondaryColor: UIColor? {
//        return SCDatabaseQueryManager.getSavedSecondaryColor()
        return SCColors.scGray
    }
}
