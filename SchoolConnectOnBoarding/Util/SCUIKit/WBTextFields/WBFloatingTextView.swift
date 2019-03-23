//
//  SCTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

/**
 A container view for WBTextView.
 - Important:
 WBTextView could live on it's own with round corners and shadow. The problem is for shadow you cannot mask to bounds.
 Therefore, the text would scroll past the view's bounds as they type.
*/
class WBFloatingTextView: UIView, Shadowable {
    
    // MARK: - Properties
    var validationType: WBTextValidationType

    // MARK: - UIElements
    lazy var floatingTextView: WBTextView! = {
        let textView = WBTextView(type: validationType)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     - parameters:
        - type: Validation type for isValid. Will also populate title and placeholder.
        - withShadow: Determines if the container will have the drop shadow effect. Defaults to true.
    */
    required init(type: WBTextValidationType, withShadow: Bool = true) {
        
        self.validationType = type
        super.init(frame: .zero)
        setupTextView()
        customizeUI(withShadow)
    }
    
    // MARK: - Methods
    private func setupTextView(){
        addSubview(floatingTextView)
        floatingTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3.0).isActive = true
        floatingTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        floatingTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        floatingTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    ///Calls Shadowable protocol method based on bool passed in from Init.
    private func customizeUI(_ withShadow: Bool) {
        if withShadow {
            makeShadow()
        }
    }
    
}

/**
 Standard text view to be wrapped in a container.
 Conforms to Validatable for text validation.
 */
class WBTextView: UITextView, Validatable, CornerRoundable {
    
    
    // MARK: - Properties
    var validationType: WBTextValidationType

    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     - parameters:
        - type: Validation type used to determine the placeholder text.
     */
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero, textContainer: nil)
        formatTextView()
    }
    
    // MARK: - Methods
    
    ///Style formating
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
