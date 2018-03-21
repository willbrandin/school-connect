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
        makeRoundCorners()
        configureViewFor(feature)
    }
    
    
    
    //MARK: - Methods
    func makeRoundCorners(){
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
    }
    
    //Move to View Model? Or refactor out?
    func configureViewFor(_ featureType: HomeFeature) {
        switch featureType {
        case .bullyReporting:
            featureTitleLabel.text = "Bully Reporting"
            featureSubtitleText.text = "Report instances of bullying directly to your principal."
            
            backgroundImageView.image = UIImage(named: "classroom")


        case .teacherContact:
            featureTitleLabel.text = "Contact your Teacher"
            featureSubtitleText.text = "Reach your teacher from your mobile device."
            backgroundImageView.image = UIImage(named: "landingPageIcon")

        case .mapOfSchool:
            featureTitleLabel.text = "School Map"
            featureSubtitleText.text = "Get an arial view of the school!"
            backgroundImageView.image = UIImage(named: "student-walk")

        }
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
