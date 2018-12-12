//
//  ConfirmationView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class ConfirmationView: UIView {

    //MARK: - Properties
    
    weak var confirmationDelegate: ConfirmationDelegate?
    
    //MARK: - UI Elements
    
    var logoImgView: SCCircleImage! = {
        let imageView = SCCircleImage()
        imageView.image = SCImages.OnBoardingImages.landingPageIcon
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var schoolNameLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.heroTitle
        label.textColor = SCColors.scGrayText
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var schoolCityStateLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.bodyText
        label.textColor = SCColors.scGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var confirmButton: SCRoundedButton! = {
        let button = SCRoundedButton()
        button.backgroundColor = SCColors.scGreen
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.formatBoldButtonTitle()
        button.addTarget(self, action: #selector(handleConfirmationTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bodyTextStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(schoolNameLabel)
        stackView.addArrangedSubview(schoolCityStateLabel)
        stackView.spacing = 8.0
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Methods
    
    func customizeUI(_ school: School){
        backgroundColor = UIColor.white
        setupButtonConstraints()
        setupImageConstraints()
        setupSchoolInfoStackViewConstraints()

        if let name = school.schoolName, let city = school.schoolCity, let state = school.schoolState {
            schoolNameLabel.text = name
            schoolCityStateLabel.text = "\(city), \(state)"
        }
    }
    
    func setupImageConstraints() {
        addSubview(logoImgView)
        logoImgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImgView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -20.0).isActive = true
        logoImgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        logoImgView.widthAnchor.constraint(equalTo: logoImgView.heightAnchor).isActive = true
    }
    
    func setupSchoolInfoStackViewConstraints() {
        addSubview(bodyTextStackView)
        
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        bodyTextStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50.0).isActive = true
    }
    
    func setupButtonConstraints() {
        addSubview(confirmButton)
        confirmButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0).isActive = true
        
    }
    
    @objc func handleConfirmationTap(){
        self.confirmationDelegate?.didConfirmSchool()
    }
}
