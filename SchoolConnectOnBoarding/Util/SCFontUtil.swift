//
//  SCFontUtil.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/22/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit


enum FontBook: String {
    
    case bold = "AvenirNext-Bold"
    case semiBold = "AvenirNext-DemiBold"
    case medium = "AvenirNext-Medium"
    case regular = "AvenirNext-Regular"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

extension UIFont {
    
    static func heroTitle() -> UIFont {
        return FontBook.semiBold.of(size: 28.0)
    }
    
    static func title() -> UIFont {
        return FontBook.semiBold.of(size: 26.0)
    }
    
    static func boldTitle() -> UIFont {
        return FontBook.bold.of(size: 26.0)
    }
    
    static func textFieldPlaceholder() -> UIFont {
        return FontBook.bold.of(size: 18.0)
    }
    
    static func textFieldTitle() -> UIFont {
        return FontBook.semiBold.of(size: 14.0)
    }
    
    static func buttonTitle() -> UIFont {
        return FontBook.bold.of(size: 18.0)
    }
    
    static func heading() -> UIFont {
        return FontBook.bold.of(size: 22.0)
    }
    
    static func subHeading() -> UIFont {
        return FontBook.bold.of(size: 14.0)
    }
    
    static func bodyText() -> UIFont {
        return FontBook.regular.of(size: 18.0)
    }
    
    static func altBodyText() -> UIFont {
        return FontBook.regular.of(size: 14.0)
    }
    
    static func dateSubTitle() -> UIFont {
        return FontBook.bold.of(size: 13.0)
    }
    
    static func boldText() -> UIFont {
        return FontBook.semiBold.of(size: 16.0)
    }
    
    
    
}
