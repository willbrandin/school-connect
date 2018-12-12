//
//  SearchBlankView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SearchBlankView: UIView {

    var searchImgView: SCCircleImage! = {
        let imageView = SCCircleImage()
        imageView.image = SCImages.OnBoardingImages.searchIcon
        imageView.alpha = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var searchLabel: UILabel! = {
        let label = UILabel()
        label.text = "Find your school"
        label.textAlignment = .center
        label.font = SCFont.bodyText
        label.textColor = SCColors.scGrayText
        label.alpha = 0.8
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func customizeUI(){
        self.backgroundColor = UIColor.white
        setupImageConstraints()
        setupLabelConstraints()
    }
    
    func setupImageConstraints(){
        addSubview(searchImgView)
        searchImgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50.0).isActive = true
        searchImgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.18).isActive = true
        searchImgView.widthAnchor.constraint(equalTo: searchImgView.heightAnchor).isActive = true
    }
    
    func setupLabelConstraints(){
        addSubview(searchLabel)
        searchLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 40.0).isActive = true
        searchLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        searchLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        searchLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
}
