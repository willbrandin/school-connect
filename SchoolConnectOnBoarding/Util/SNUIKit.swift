//
//  SNUIKit.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SNCircleImage: UIImageView {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}

class SNRoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        makeShadow()
    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
    }
    
    
    func updateCornerRadius() {
        self.layer.cornerRadius = frame.size.height/4
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 12)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 18.0
        self.layer.masksToBounds = false
    }
}
