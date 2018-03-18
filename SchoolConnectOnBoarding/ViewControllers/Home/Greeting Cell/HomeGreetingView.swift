//
//  NewsCardView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeGreetingView: UIView {
    
    //MARK: - Properties
    
    
    //MARK: - UI Elements
    lazy var welcomeTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26.0, weight: .semibold)
        label.text = "Welcome to School Connect!"
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var todaysDateLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Today's Date: 12/25/2018"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var homeHeroImg: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = UIImage.landingPageIcon()
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - StackView
    
    lazy var titleTextStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(welcomeTitleLabel)
        stackView.addArrangedSubview(todaysDateLabel)
        
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //MARK: - Init
    //TODO: - Need School Obj.
    func customizeUI(){
        backgroundColor = UIColor.white

        makeRoundCorners()
        setupStackViewContraints()
    }
    
    
    
    //MARK: - Methods
    
    func setupStackViewContraints(){
        addSubview(titleTextStackView)
        
        titleTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        titleTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        titleTextStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        titleTextStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        setupImgConstraints()
    }
    
    func setupImgConstraints(){
        addSubview(homeHeroImg)
        //1/4th of the calculated height above
        if let cellSuperView = superview {
            
            let calculatedHeight = cellSuperView.frame.height * 0.25 * 0.25
            homeHeroImg.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            homeHeroImg.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            homeHeroImg.topAnchor.constraint(equalTo: titleTextStackView.bottomAnchor, constant: calculatedHeight).isActive = true
            homeHeroImg.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        } else {
            homeHeroImg.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            homeHeroImg.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            homeHeroImg.topAnchor.constraint(equalTo: titleTextStackView.bottomAnchor, constant: 15.0).isActive = true
            homeHeroImg.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        
        
    }
   
    func makeRoundCorners(){
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
    }
    
    
    
}

