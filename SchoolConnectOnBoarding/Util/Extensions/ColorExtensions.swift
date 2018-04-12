//
//  ColorExtensions.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

extension UIColor {
    
    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.7
    }
    
    
    convenience init(hex: String) {
        let filtered = hex.removeSpecialCharactersFromText()
        let scanner = Scanner(string: filtered)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    
    class func scGreen() -> UIColor {
        return UIColor(hex: "1dd1a1") // used
    }
    
    class func scBlue() -> UIColor {
        return UIColor(hex: "3498db") //used
    }
    
    class func scGray() -> UIColor {
        return UIColor(hex: "2d3436") // used
    }
    
    class func scGrayText() -> UIColor {
        return UIColor(hex: "555555") //used
    }
    
    class func scRed() -> UIColor {
        return UIColor(hex: "e55039") // used
    }
    
    class func textFieldPlaceholder() -> UIColor {
        
        return UIColor(hex: "C7C7CD").withAlphaComponent(0.7)
    }
    
}
