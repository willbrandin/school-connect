//
//  SCFloatingTextField.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit


protocol Validatable {
    associatedtype T
    
    func validate(_ functions: [T]) -> Bool
    func isValid()->Bool
}

protocol Evaluatable {
    associatedtype T
    
    func evaluate(with condition: T) -> Bool
}

extension Validatable where Self: SCFloatingTextField {
    
    func validate(_ functions: [(String) -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "") }.reduce(true) { $0 && $1 }
    }
    
    func isValid() -> Bool {
        
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


class SCFloatingTextField: UITextField, Validatable, Shadowable, CornerRoundable {
    
    //MARK: - Properties
    var validationType: WBTextValidationType
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero)
        formatTextField()
    }
    
    //MARK: - Methods
    
    func formatTextField(){
        
        self.borderStyle = .none
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.returnKeyType = .next
        self.contentVerticalAlignment = .center
        self.font = UIFont.textFieldPlaceholder()
        self.textColor = UIColor.black
        
        
        roundCorners()
        makeShadow()
        
    }
    
    func addSpacer(){
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        self.leftViewMode = .always
        self.leftView = spacerView
    }
    
}

