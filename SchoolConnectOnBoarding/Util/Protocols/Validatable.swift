//
//  Validatable.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/17/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol Validatable {
    associatedtype T
    func validate(_ functions: [T]) -> Bool
}

protocol Evaluatable {
    associatedtype T
    func evaluate(with condition: T) -> Bool
}

extension Validatable where Self: SCFloatingTextField {
    
    func validate(_ functions: [(String) -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "") }.reduce(true) { $0 && $1 }
    }
    
    var isValid: Bool {
        switch self.validationType {
        case .email: return self.validate([String.isEmailValid])
        case .phoneNumber: return self.validate([String.isPhoneNumberValid])
        case .name: return self.validate([String.isValidName])
        default:
            break
        }
        return false
    }
    
}



extension Validatable where Self: SCTextView {
    
    func validate(_ functions: [(String) -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "") }.reduce(true) { $0 && $1 }
    }
    
    var isValid: Bool {
       
        switch self.validationType {
        case .message: return self.validate([String.isMessageValid]) //TODO: - come up with some sort of eval method.
        default:
            break
        }
        return false
    }
    
}
