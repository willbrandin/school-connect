//
//  Shadow.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit


protocol Shadowable {
    func makeShadow()
}


extension Shadowable where Self: SCFloatingTextView {
    
    func makeShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 6.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.layer.shadowOpacity = 0.2
        
    }
}

extension Shadowable where Self: SCFloatingTextField {
    
    func makeShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowOpacity = 0.1

    }
}

extension Shadowable where Self: UICollectionViewCell {
    
    func makeShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 10.0
    }
}

extension Shadowable where Self: UIButton {
    
    func makeShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
    }
}

extension Shadowable where Self: CalendarCardView {
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 5.0
    }
}




