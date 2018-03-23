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
    lazy var featureTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26.0, weight: .semibold)
        label.text = "How can we help?"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - StackView
    
    
    
    //MARK: - Init
    func customizeUI(){
        backgroundColor = UIColor.white
        
    }
    
    
    
    //MARK: - Methods
    
  
    

}
