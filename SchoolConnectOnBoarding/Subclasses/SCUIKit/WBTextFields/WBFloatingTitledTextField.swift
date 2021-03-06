//
//  WBFloatingTitledTextField.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 5/3/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit
/**
 A UIView with a title and textField embedded in a stack view.
 During init, a validation type is provided.
 The textField placeholder text is provided by the validation RawValue.
 */
class WBFloatingTitledTextField: UIView, TextInputTitleable, WBTextFieldBindable {
    
    
    // MARK: - Properties
    var onTextChanged: ((String) -> Void)?
    
    private var validationType: WBTextValidationType!
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = text
        }
    }
    
    // MARK: - UI Elements
    lazy var textInputTitle: UILabel! = {
        let label = UILabel()
        label.font = SCFont.textFieldTitle
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: SCFloatingTextField! = {
        let textField = SCFloatingTextField(type: validationType)
        return textField
    }()
    
    lazy var inputStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(textInputTitle)
        stackView.addArrangedSubview(textField)
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: WBTextValidationType) {
        
        self.validationType = type
        super.init(frame: .zero)
        setupStackViewConstraints()
    }
    
    // MARK: - Methods
    private func setupStackViewConstraints(){
        addSubview(inputStackView)
        inputStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        inputStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        inputStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        textInputTitle.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        onTextChanged?(textField.text ?? "")
    }
}
