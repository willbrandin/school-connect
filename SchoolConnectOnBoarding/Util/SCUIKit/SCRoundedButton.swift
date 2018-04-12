//
//  SCRoundedButton.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCRoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        makeShadow()
    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = UIFont.buttonTitle()
    }
    
    
    func updateCornerRadius() {
        self.layer.cornerRadius = frame.size.height/10
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
}
