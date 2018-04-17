//
//  TextFieldExtensions.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/17/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

extension UITextField {
    
    
    func canFormatAsPhoneNumber(range: NSRange, inputString: String) -> Bool {
        //Cursor Management
        let positionOriginal = self.beginningOfDocument
        let cursorLocation = self.position(from: positionOriginal, offset: (range.location + NSString(string: inputString).length))
        
        
        let newString = (self.text! as NSString).replacingCharacters(in: range, with: inputString)
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        //let lengthOfInput = self.text!.count
        
        if length == 0 || length > 10 {
            return inputString.isValidNumberCountForPhoneNumber(self.text!.count)
        }
        
        let phoneNumber = String.formatStringAsPhoneNumber(length, decimalString)
        self.text = phoneNumber
        //Cursor Manager
        if cursorLocation != nil {
            self.selectedTextRange = self.textRange(from: cursorLocation!, to: cursorLocation!)
        }
        
        return false
    }
    
    
}
