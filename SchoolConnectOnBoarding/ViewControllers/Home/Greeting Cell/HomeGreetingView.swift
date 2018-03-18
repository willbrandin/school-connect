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
    
    
    //MARK: - StackView
    
    
    
    //MARK: - Init
    func customizeUI(){
        
        
    }
    override func layoutSubviews() {
        makeRoundCorners()
    }
    
    //MARK: - Methods
    
    
    
    
    func makeRoundCorners(){
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
    }
    
    
    
}

