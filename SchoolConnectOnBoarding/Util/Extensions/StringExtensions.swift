//
//  StringExtensions.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation


extension String {
    func removeSpecialCharactersFromText() -> String {
        
        let notAllowedChars: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ").inverted
        return self.components(separatedBy: notAllowedChars).joined(separator: "")
    }
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WBDateFormat.serverDateFormat.rawValue
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
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

extension String: Evaluatable {
    func evaluate(with condition: String) -> Bool {
        guard let range = range(of: condition, options: .regularExpression, range: nil, locale: nil) else {
            return false
        }
        
        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
    
    
    static func isPhoneNumberValid(text: String) -> Bool {
        let regexp = "^[0-9]{10}$"
        return text.evaluate(with: regexp)
    }
    
    static func isValidName(text: String) -> Bool {
        if text == nil || text.isEmpty {
            return false
        }
        let regexp = ".*[0-9]+.*"
        return !text.evaluate(with: regexp)
    }
    
    static func isMessageValid(text: String?) -> Bool {
        if text == nil || (text?.isEmpty)! {
            return false
        }
        return true
    }
    static func isEmailValid(text: String) -> Bool {
        let regexp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return text.evaluate(with: regexp)
    }
}
