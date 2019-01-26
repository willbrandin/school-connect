//
//  ContactView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/21/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ContactViewProtocol: class {
    var onNameFieldChanged: ((String) -> Void)? { get set }
    var onEmailFieldChanged: ((String) -> Void)? { get set }
    var onPhoneNumberFieldChanged: ((String) -> Void)? { get set }
}

protocol ContactFormDelegate: class {
    func didTapSubmit()
}

class ContactView: UIView, ContactViewProtocol {

    //MARK: - Properties
    var onNameFieldChanged: ((String) -> Void)?
    var onEmailFieldChanged: ((String) -> Void)?
    var onPhoneNumberFieldChanged: ((String) -> Void)?
    
    weak var formDelegate: ContactFormDelegate?
    var inputs = [WBFloatingTitledTextField?]()
    
    //MARK: - UI Elements
    
    lazy var contactTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.heroTitle
        label.text = PageTitles.contactSubtitle.rawValue
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Name Field
    lazy var nameTextTitleView: WBFloatingTitledTextField! = {
        let field = WBFloatingTitledTextField(type: .name)
        field.onTextChanged = onNameFieldChanged
        field.textField.returnKeyType = .next
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //Email Field
    lazy var emailTextTitleView: WBFloatingTitledTextField! = {
        let field = WBFloatingTitledTextField(type: .email)
        field.textField.keyboardType = .emailAddress
        field.textField.returnKeyType = .next
        field.onTextChanged = onEmailFieldChanged
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //Phone number
    lazy var phoneTextTitleView: WBFloatingTitledTextField! = {
        let field = WBFloatingTitledTextField(type: .phoneNumber)
        field.textField.keyboardType = .numberPad
        field.textField.returnKeyType = .next
        field.onTextChanged = onPhoneNumberFieldChanged
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    //Phone number
    lazy var messageTextTitleView: WBFloatingTitledTextView! = {
        let textView = WBFloatingTitledTextView(type: .message)
        //textView.textView.floatingTextView.returnKeyType = .done
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var buttonContainerStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(submitButton)
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var submitButton: SCRoundedSchoolButton! = {
        let button = SCRoundedSchoolButton()
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setColor(true)
        button.addTarget(self, action: #selector(handleSubmitButtonTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Main stack and scroll view
    
    lazy var mainStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(contactTitleLabel)
        stackView.addArrangedSubview(nameTextTitleView)
        stackView.addArrangedSubview(emailTextTitleView)
        stackView.addArrangedSubview(phoneTextTitleView)
        stackView.addArrangedSubview(messageTextTitleView)
        stackView.addArrangedSubview(buttonContainerStackView)
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mainScrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.addSubview(mainStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    //MARK: - Methods
    
    func customizeUI(){
        setupScrollViewConstraints()
        setupInputConstraints()
        setupButtonContainerConstraints()
    }
    
    func setupScrollViewConstraints(){
        addSubview(mainScrollView)
        mainScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        setupStackViewConstraints()
    }
    
    func setupStackViewConstraints() {
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 20.0).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -30.0).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 12.0).isActive = true
       
        mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -12.0).isActive = true
    }
    
    func setupButtonContainerConstraints() {
        buttonContainerStackView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        submitButton.heightAnchor.constraint(equalTo: buttonContainerStackView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupInputConstraints() {
        let inputArray = [nameTextTitleView, emailTextTitleView, phoneTextTitleView]
        inputs = inputArray
        
        for input in inputArray {
            input?.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
            input?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            input?.heightAnchor.constraint(equalToConstant: 90.0).isActive = true
        }
        
        messageTextTitleView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        messageTextTitleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageTextTitleView.heightAnchor.constraint(equalToConstant: 260.0).isActive = true
    }
    
    @objc func handleSubmitButtonTap(){
        self.formDelegate?.didTapSubmit()
    }
    
}
