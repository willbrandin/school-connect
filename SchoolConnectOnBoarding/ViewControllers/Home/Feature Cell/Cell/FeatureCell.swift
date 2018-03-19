//
//  FeatureCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/19/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class FeatureCell: SCHomeCollectionViewCell {
    
    //MARK: - Properties
    var cardView: FeatureCardView!
    static var reuseID = "FeatureCell"
    
    //MARK: - UI Elements
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //MARK: - Methods
    func configureCell(){
        setupCardViewConstraints()
        cardView.customizeUI()
    }
    
    func setupCardViewConstraints(){
        cardView = FeatureCardView()
        addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0).isActive = true
    }
    
   
    
    
}
