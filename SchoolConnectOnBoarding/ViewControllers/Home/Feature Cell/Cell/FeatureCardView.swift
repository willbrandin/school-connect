//
//  HomeFeatureView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class FeatureCardView: UIView, CornerRoundable {

    
    //MARK: - Properties
    
    
    //MARK: - UI Elements
    
    var backgroundImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var featureTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.boldTitle
        label.text = "Feature Name"
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var featureSubtitleText: UILabel! = {
        let label = UILabel()
        label.font = SCFont.bodyText
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    
    //MARK: - StackView
    lazy var bodyTextStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(featureTitleLabel)
        stackView.addArrangedSubview(featureSubtitleText)
        
        stackView.distribution = .fillProportionally

        stackView.alignment = .leading
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Init
    func customizeUI(_ feature: HomeFeature){
        backgroundColor = UIColor.white
        setupBackgroundImageView()
        setupTextStackView()
        roundCorners()
        feature.customizeHomeFeatureUI(self)
    }
    
    
    
    //MARK: - Methods
    
    
    //Move to View Model? Or refactor out?
    func configureCardView(_ title: String, _ subtitle: String, _ image: UIImage?) {
        self.featureTitleLabel.text = title
        self.featureSubtitleText.text = subtitle
        self.backgroundImageView.image = image
    }
    
  
    func setupBackgroundImageView(){
        addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
    func setupTextStackView(){
        addSubview(bodyTextStackView)
        bodyTextStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0).isActive = true
        bodyTextStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
    }
    
}
