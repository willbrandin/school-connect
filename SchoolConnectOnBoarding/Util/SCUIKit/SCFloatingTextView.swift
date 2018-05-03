//
//  SCTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit


class SCTextView: UITextView, Validatable, CornerRoundable, Shadowable {
    
    
    //MARK: - Properties
    var validationType: WBTextValidationType
    
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero, textContainer: nil)
        formatTextField()
        makeShadow()
    }
    
    //MARK: - Methods
    func formatTextField(){
        self.text = self.validationType.rawValue
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.font = SCFont.textFieldPlaceholder
        self.textColor = SCColors.textFieldPlaceholder
        self.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        roundCorners()
    }
    
    
    
}
