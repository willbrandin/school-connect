//
//  WBFloatingTitleTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 5/3/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class WBFloatingTitledTextView: UIView, TextInputTitleable {
    
    private var validationType: WBTextValidationType!
    
    lazy var textInputTitle: UILabel! = {
        let label = UILabel()
        //label.text = "Search"
        label.font = SCFont.textFieldTitle
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: SCFloatingTextView! = {
        let textField = SCFloatingTextView(type: validationType)
        return textField
    }()
    
    lazy var nameStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(textInputTitle)
        stackView.addArrangedSubview(textView)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Init
    func initSearchBar(type: WBTextValidationType){
        self.validationType = type
        setupStackViewConstraints()
    }
    
    private func setupStackViewConstraints(){
        addSubview(nameStackView)
        nameStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        textView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        textInputTitle.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    
}
