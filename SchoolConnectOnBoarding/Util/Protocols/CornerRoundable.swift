//
//  CornerRoundable.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit


protocol CornerRoundable {
    func roundCorners()
}

extension CornerRoundable where Self: SCTextView {
    
    func roundCorners(){
        self.layer.borderWidth = self.frame.height/10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6.0
    }
}

extension CornerRoundable where Self: SCFloatingTextField {
    
    func roundCorners(){
        self.layer.borderWidth = self.frame.height/10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6.0
    }
}

extension CornerRoundable where Self: UIButton {
    
    func roundCorners(){
        self.layer.cornerRadius = frame.size.height/10

    }
}

extension CornerRoundable where Self: UIView {
    
    func roundCorners(){
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
    }
}

extension CornerRoundable where Self: CalendarCardView {
    
    func roundCorners(){
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
    }
}

extension CornerRoundable where Self: SCCircleImage {
    func roundCorners(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}



