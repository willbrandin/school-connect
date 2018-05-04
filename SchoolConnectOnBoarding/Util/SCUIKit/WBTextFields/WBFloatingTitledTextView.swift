//
//  WBFloatingTitleTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 5/3/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

/**
 A UIView with a title and TextView embedded in a stack view.
 During init, a validation type is provided.
 TextView placeholder text is provided by the validation RawValue.
 */
class WBFloatingTitledTextView: UIView, TextInputTitleable {
    
    
    //MARK: - Properties
    private var validationType: WBTextValidationType!
    ///For convenience. A reference to the text view inside of the WBFloatingTextView
    ///Prevents *.textView.textView* over and over again
    var floatingTextView: WBTextView?
    
    
    //MARK: - UI Elements
    lazy var textInputTitle: UILabel! = {
        let label = UILabel()
        label.font = SCFont.textFieldTitle
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: WBFloatingTextView! = {
        let textField = WBFloatingTextView(type: validationType)
        return textField
    }()
    
    lazy var inputStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(textInputTitle)
        stackView.addArrangedSubview(textView)
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     - parameters:
        - type: Validation type to init the WBFloatingTextView
     */
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero)
        setupStackViewConstraints()
        self.floatingTextView = textView.floatingTextView
    }
    
    //MARK: - Methods
    private func setupStackViewConstraints(){
        addSubview(inputStackView)
        inputStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        inputStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        textView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        textInputTitle.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    
}
