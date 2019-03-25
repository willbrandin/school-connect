//
//  NewsCardView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeGreetingView: UIView, CornerRoundable, Shadowable {
    
    // MARK: - UI Elements
    lazy var welcomeTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.heroTitle
        label.text = "Welcome to School Connect!"
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var todaysDateLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.dateSubTitle
        label.textColor = SCColors.scGrayText
        label.text = "Today's Date: 12/25/2018"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    var heroImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = SCImages.FeatureImages.mapOfSchoolImage
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - StackView
    
    lazy var titleTextStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(welcomeTitleLabel)
        stackView.addArrangedSubview(todaysDateLabel)
        
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = Style.Layout.innerSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        makeShadow()
        setupStackViewContraints()
    }
    
    // MARK: - Methods
    
    func makeShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
       
    // MARK: - Private Methods
    
    private func setupStackViewContraints() {
        addSubview(titleTextStackView)
        titleTextStackView.pinToBottomMargin(constant: -Style.Layout.innerSpacing)
        titleTextStackView.pinToLeadingAndTrailingMargins()
        titleTextStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        setupImageConstraints()
    }
    
    private func setupImageConstraints() {
        addSubview(heroImage)
        heroImage.pinToTop()
        heroImage.pinToLeadingAndTrailing()
        heroImage.pinAboveView(view: titleTextStackView, constant: Style.Layout.innerSpacing)
    }
}
