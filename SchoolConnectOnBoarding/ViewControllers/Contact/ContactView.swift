//
//  ContactView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/21/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class ContactView: UIView {

    //MARK: - Properties
    weak var formDelegate: ContactFormDelegate?
    var inputs = [SCFloatingTextField?]()
    
    //MARK: - UI Elements
    
    lazy var contactTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.heroTitle()
        label.text = "How may we help you?"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Name Field
    lazy var nameFieldTitle: UILabel! = {
        let label = UILabel()
        label.font = UIFont.textFieldTitle()
        label.text = ""
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: SCFloatingTextField! = {
        let textField = SCFloatingTextField()
        textField.placeholder = "Name"
    
        textField.addSpacer()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var nameStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(nameFieldTitle)
        stackView.addArrangedSubview(nameTextField)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //Email Field
    lazy var emailFieldTitle: UILabel! = {
        let label = UILabel()
        label.font = UIFont.textFieldTitle()
        label.text = ""
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: SCFloatingTextField! = {
        let textField = SCFloatingTextField()
        textField.placeholder = "E Mail"
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addSpacer()
        
        return textField
    }()
    
    lazy var emailStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(emailFieldTitle)
        stackView.addArrangedSubview(emailTextField)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //Phone number
    lazy var phoneNumberFieldTitle: UILabel! = {
        let label = UILabel()
        label.font = UIFont.textFieldTitle()
        label.text = ""
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberTextField: SCFloatingTextField! = {
        let textField = SCFloatingTextField()
        textField.placeholder = "Phone Number"
        textField.keyboardType = .numberPad
        textField.addSpacer()
        
        return textField
    }()
    
    lazy var phoneStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(phoneNumberFieldTitle)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //Phone number
    lazy var messageTextTitle: UILabel! = {
        let label = UILabel()
        label.font = UIFont.textFieldTitle()
        //label.text = "Message"
        label.textColor = UIColor.lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageTextView: SCFloatingTextView! = {
        let textView = SCFloatingTextView()
        textView.initializeUI()
        textView.textView.text = "Message"
        textView.textView.textColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var messageStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(messageTextTitle)
        stackView.addArrangedSubview(messageTextView)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //Submit Button
    
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
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(emailStackView)
        stackView.addArrangedSubview(phoneStackView)
        stackView.addArrangedSubview(messageStackView)
        stackView.addArrangedSubview(buttonContainerStackView)
        stackView.axis = .vertical
        stackView.spacing = 30.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mainScrollView: UIScrollView! = {
        let scrollView = UIScrollView()
        scrollView.addSubview(mainStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    
    //MARK: - Init View
    
    
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
        let inputArray = [nameTextField, emailTextField, phoneNumberTextField]
        inputs = inputArray
        for input in inputArray {
            
            input?.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
            input?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            input?.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        }
        
        messageTextView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        messageTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageTextView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        setupInputTitleConstraints()
    }
    
    func setupInputTitleConstraints(){
        let titles = [nameFieldTitle, emailFieldTitle, phoneNumberFieldTitle, messageTextTitle]
        for title in titles {
            title?.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        }
    }
    
    
    @objc func handleSubmitButtonTap(){
        self.formDelegate?.didTapSubmit()
    }
    
    
    
}
