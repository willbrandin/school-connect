//
//  SCFloatingTextView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit


extension Validatable where Self: SCTextView {
    
    func validate(_ functions: [(String) -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "") }.reduce(true) { $0 && $1 }
    }
    
    func isValid() -> Bool {
        
        switch self.validationType {
            
        case .message: return self.validate([String.isMessageValid]) //TODO: - come up with some sort of eval method.
        default:
            break
        }
        return false
    }
}

class SCFloatingTextView: UIView {
    
    //MARK: - Properties
    var validationType: WBTextValidationType
    
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
    
    func makeShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowOpacity = 0.1
        
    }
    
    
    
}


class SCTextView: UITextView, Validatable {
    
    
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
        
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.font = UIFont.textFieldPlaceholder()
        self.textColor = UIColor.black
        self.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        roundCorners()
    }
    func roundCorners(){
        self.layer.borderWidth = self.frame.height/10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6.0
    }
    
    
}
