//
//  Extensions.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func landingPageIcon() -> UIImage {
        return UIImage(named: "landingPageIcon")!
    }
    
    static func searchIcon() -> UIImage {
        return UIImage(named: "searchIcon")!
    }
}

extension UIColor {
    
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
    
    class func cfnBlue() -> UIColor {
        return UIColor(hex: "2980b9")
    }
    
    class func cfnGreen() -> UIColor {
        return UIColor(hex: "3CB5A4")
    }
    
    class func cfnGray() -> UIColor {
        return UIColor(hex: "757575")
    }
    
    
    class func scEmerald() -> UIColor {
        return UIColor(hex: "2ecc71")
    }
    
    class func scBlue() -> UIColor {
        return UIColor(hex: "3498db")
    }
    
    class func scMidnightBlue() -> UIColor {
        return UIColor(hex: "2c3e50")
    }
    
    class func scGray() -> UIColor {
        return UIColor(hex: "2d3436")
    }
    
    class func scGrayText() -> UIColor {
        return UIColor(hex: "3d3d3d")
    }
    
    class func scRed() -> UIColor {
        return UIColor(hex: "e55039")
    }
    
    
}

extension String {
    func removeSpecialCharactersFromText() -> String {
        
        let notAllowedChars: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ").inverted
        return self.components(separatedBy: notAllowedChars).joined(separator: "")
    }
}
