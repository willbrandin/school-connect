//
//  SCRoundedBtn.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCRoundedSchoolButton: UIButton {
    
    var withShadow: Bool
    
    required init(withShadow: Bool = true) {
        self.withShadow = withShadow
        
        super.init(frame: .zero)
        self.setColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        formatBoldButtonTitle()
        
        
        if withShadow {
            makeShadow()
        }
        
    }
    //
    //    override open var isHighlighted: Bool {
    //        didSet {
    //            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
    //        }
    //    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = UIFont.buttonTitle()
    }
    
    
    func updateCornerRadius() {
        self.layer.cornerRadius = frame.size.height/10
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
    }
    
    func setColor(_ withSchoolColor: Bool = false){
        guard let primaryColor = SCDatabaseQueryManager.getSavedPrimaryColor() else { return }
        guard let secondaryColor = SCDatabaseQueryManager.getSavedSecondaryColor() else { return }
        
        if !withSchoolColor {
            self.backgroundColor = UIColor.white
            
            if primaryColor.isLight && secondaryColor.isLight {
                self.setTitleColor(UIColor.scGray(), for: .normal)
            }else if primaryColor.isLight {
                self.setTitleColor(secondaryColor, for: .normal)
            } else {
                self.setTitleColor(primaryColor, for: .normal)
            }
        } else {
            self.backgroundColor = secondaryColor
            if secondaryColor.isLight {
                setTitleColor(UIColor.black, for: .normal)
            } else {
                setTitleColor(UIColor.white, for: .normal)
            }
        }
        
        
    }
}
