//
//  SCTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit


class SCFloatingTextView: UIView, Shadowable {
    
    //MARK: - Properties
    var validationType: WBTextValidationType

    //MARK: - UIElements
    lazy var floatingTextView: SCTextView! = {
        let textView = SCTextView(type: validationType)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: WBTextValidationType, withShadow: Bool = true) {
        
        self.validationType = type
        super.init(frame: .zero)
        setupTextView()
        customizeUI(withShadow)
    }
    
    //MARK: - Methods
    func setupTextView(){
        addSubview(floatingTextView)
        floatingTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3.0).isActive = true
        floatingTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        floatingTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        floatingTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func customizeUI(_ withShadow: Bool) {
        if withShadow {
            makeShadow()
        }
    }
    
    
    
}

class SCTextView: UITextView, Validatable, CornerRoundable {
    
    
    //MARK: - Properties
    var validationType: WBTextValidationType

    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero, textContainer: nil)
        formatTextView()
    }
    
    //MARK: - Methods
    
    
    private func formatTextView(){
        self.text = self.validationType.rawValue
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .yes
        self.keyboardType = .default
        self.font = SCFont.textFieldPlaceholder
        self.textColor = SCColors.textFieldPlaceholder
        self.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        roundCorners()
    }
    
    
    
}
