//
//  SCFloatingTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit



class SCFloatingTextView: UIView, Shadowable {
    
    //MARK: - Properties
    private var validationType: WBTextValidationType
    
    //MARK: - UIElements
    lazy var textView: SCTextView! = {
        let textView = SCTextView(type: self.validationType)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero)
        setupTextView()
        makeShadow()
    }
    
    //MARK: - Methods
    func setupTextView(){
        addSubview(textView)
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3.0).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
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
        formatTextField()
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
