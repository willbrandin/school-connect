//
//  SCUIKit.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCCircleImage: UIImageView {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}

class SCRoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
        makeShadow()
    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
    }
    
    
    func updateCornerRadius() {
        self.layer.cornerRadius = frame.size.height/10
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
}

class SCRoundedSchoolButton: UIButton {
    
    var withShadow: Bool
    
    required init(withShadow: Bool = true) {
        self.withShadow = withShadow
        
        super.init(frame: .zero)
        self.setColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
        formatBoldButtonTitle()
     

        if withShadow {
            makeShadow()
        }
        
    }
//    
//    override open var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
//        }
//    }
    
    func formatBoldButtonTitle(){
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
    }
    
    
    func updateCornerRadius() {
        self.layer.cornerRadius = frame.size.height/10
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
    }
    
    func setColor(_ withSchoolColor: Bool = false){
        guard let primaryColor = SCDatabaseQueryManager.getSavedPrimaryColor() else { return }
        guard let secondaryColor = SCDatabaseQueryManager.getSavedSecondaryColor() else { return }
        
        if !withSchoolColor {
            self.backgroundColor = UIColor.white
            
            if primaryColor.isLight && secondaryColor.isLight {
                self.setTitleColor(UIColor.scGray(), for: .normal)
            }else if primaryColor.isLight {
                self.setTitleColor(secondaryColor, for: .normal)
            } else {
                self.setTitleColor(primaryColor, for: .normal)
            }
        } else {
            self.backgroundColor = secondaryColor
            if secondaryColor.isLight {
                setTitleColor(UIColor.black, for: .normal)
            } else {
                setTitleColor(UIColor.white, for: .normal)
            }
        }
        
        
    }
}



class SCHomeCollectionViewCell: UICollectionViewCell {
    
    
    override func layoutSubviews() {
        
        makeShadow()
       
    }
    
    func makeShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 10.0
    }
    
}


class SCFloatingTextField: UITextField {
    
    //MARK: - Init
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        formatTextField()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        formatTextField()
    }

    //MARK: - Methods
    
    func formatTextField(){
        
        self.borderStyle = .none
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.returnKeyType = .next
        self.contentVerticalAlignment = .center
        self.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        self.textColor = UIColor.black
        
        roundCorners()
        makeShadow()
    }
    
    func addSpacer(){
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        self.leftViewMode = .always
        self.leftView = spacerView
    }
    
    func makeShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowOpacity = 0.1
    }
    
    func roundCorners(){
        self.layer.borderWidth = self.frame.height/10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6.0
    }
    
    
}

class SCFloatingTextView: UIView {

    //MARK: - Properties
    //MARK: - UIElements
    lazy var textView: SCTextView! = {
        let textView = SCTextView()
        textView.formatTextField()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - Init
    func initializeUI(){
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


class SCTextView: UITextView {
    
    //MARK: - Init
    //MARK: - Methods
    
    func formatTextField(){
        
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.keyboardType = .default
        self.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
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













