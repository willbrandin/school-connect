//
//  HomeFeatureView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class FeatureCardView: UIView {

    
    //MARK: - Properties
    
    
    //MARK: - UI Elements
    
    var backgroundImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "classroom")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var featureTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26.0, weight: .bold)
        label.text = "Feature Name"
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var featureSubtitleText: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
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
        
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Init
    func customizeUI(){
        backgroundColor = UIColor.white
        setupBackgroundImageView()
        setupTextStackView()
        makeRoundCorners()
    }
    
    
    
    //MARK: - Methods
    func makeRoundCorners(){
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
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
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0).isActive = true
        bodyTextStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
    }

}
