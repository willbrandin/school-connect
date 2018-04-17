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
 
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: self)
    }
    
    
    static func formatStringAsPhoneNumber(_ length: Int, _ decimalString: NSString) -> String {
        
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if length - index > 3 {
            let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", areaCode)
            index += 3
        }
        
        if length - index > 3 {
            let prefix = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        
        return formattedString as String
    }
    
    func isValidNumberCountForPhoneNumber(_ inputLength: Int) -> Bool {
        let newLength = inputLength //+ self.count //- rangeLength as Int
        if newLength > 10 {
            return false
        } else {
            return true
        }
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
        let newText = text.replacingOccurrences(of: "-", with: "")
        let regexp = "^[0-9]{10}$"
        return newText.evaluate(with: regexp)
    }
    
    static func isValidName(text: String) -> Bool {
        if text.isEmpty {
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
