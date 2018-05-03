//
//  SCFloatingTextField.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCFloatingTextField: UITextField, Validatable, Shadowable, CornerRoundable {
    
    //MARK: - Properties
    var validationType: WBTextValidationType
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: WBTextValidationType, withShadow: Bool = true) {
        
        self.validationType = type
        super.init(frame: .zero)
        formatTextField()
        customizeUI(withShadow)
    }
    
    //MARK: - Methods
    
    private func customizeUI(_ withShadow: Bool) {
        roundCorners()
        addSpacer()
        
        if withShadow {
            makeShadow()
            
        }
    }
    
    private func formatTextField(){
        
        self.placeholder = self.validationType.rawValue
        self.borderStyle = .none
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.contentVerticalAlignment = .center
        self.font = SCFont.textFieldPlaceholder
        self.textColor = UIColor.black

    }
    
    private func addSpacer(){
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.leftViewMode = .always
        self.leftView = spacerView
    }
    
}













