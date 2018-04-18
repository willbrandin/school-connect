//
//  SCRoundedBtn.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCRoundedSchoolButton: UIButton, Shadowable, CornerRoundable {

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
        
        roundCorners()
        formatBoldButtonTitle()
       
        if withShadow {
            makeShadow()
        }
    }
 
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = SCFont.buttonTitle
    }
}


extension SCRoundedSchoolButton: SchoolColorable {
    
    
    func setColor(_ withSchoolColor: Bool = false){
        guard let primaryColor = schoolPrimaryColor else { return }
        guard let secondaryColor = schoolSecondaryColor else { return }
        
        if !withSchoolColor {
            self.backgroundColor = UIColor.white
            
            if primaryColor.isLight && secondaryColor.isLight {
                self.setTitleColor(SCColors.scGray, for: .normal)
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



