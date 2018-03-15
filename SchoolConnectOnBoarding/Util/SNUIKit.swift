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
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 18.0
        self.layer.masksToBounds = false
    }
}

class SNRoundedSchoolButton: UIButton {
    
    var withShadow: Bool
    
    required init(withShadow: Bool = true) {
        self.withShadow = withShadow

        super.init(frame: .zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        formatBoldButtonTitle()
        setColor()
        
        if withShadow {
            makeShadow()
        }
        
    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
    }
    
    
    func updateCornerRadius() {
        self.layer.cornerRadius = frame.size.height/4
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false
    }
    
    func setColor(){
        guard let primaryColor = SNDatabaseQueryManager.getSavedPrimaryColor() else { return }
        guard let secondaryColor = SNDatabaseQueryManager.getSavedSecondaryColor() else { return }
        self.backgroundColor = UIColor.white
        if primaryColor.isLight && secondaryColor.isLight {
            self.setTitleColor(UIColor.scGray(), for: .normal)
        }else if primaryColor.isLight {
            self.setTitleColor(secondaryColor, for: .normal)
        } else {
            self.setTitleColor(primaryColor, for: .normal)
        }
    }
}
