//
//  SCRoundedButton.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCRoundedButton: UIButton, Shadowable, CornerRoundable {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners()
        makeShadow()
    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = SCFont.buttonTitle
    }
}
