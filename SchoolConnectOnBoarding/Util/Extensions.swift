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
    
    static func homeTabBarIcon() -> UIImage {
        return UIImage(named: "diamond_round")!
    }
    
    static func newsTabBarIcon() -> UIImage {
        return UIImage(named: "news_grid")!
    }
    
    static func calendarTabBarIcon() -> UIImage {
        return UIImage(named: "calendar")!
    }
    
    static func contactTabBarIcon() -> UIImage {
        return UIImage(named: "email")!
    }
    
    
}

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
        return UIColor(hex: "555555")
    }
    
    class func scRed() -> UIColor {
        return UIColor(hex: "e55039")
    }
    
    
    
    
}

extension Int {
    func adjustForSize(size: CGFloat) -> Int {
        return self * Int(size) / 100
    }
}

extension String {
    func removeSpecialCharactersFromText() -> String {
        
        let notAllowedChars: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ").inverted
        return self.components(separatedBy: notAllowedChars).joined(separator: "")
    }
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WBDateFormat.serverDateFormat.rawValue
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let date = dateFormatter.date(from: self)!
        return date
    }
    
    func stringWithDateFormat(_ format: WBDateFormat) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue // Your New Date format as per requirement change it own
        let date = self.stringToDate()
        
        return dateFormatter.string(from: date)
        
    }
    
    func isValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPasswordForSignUp() -> Bool {
        guard self != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: self)
    }
    
    
}

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
    
}

