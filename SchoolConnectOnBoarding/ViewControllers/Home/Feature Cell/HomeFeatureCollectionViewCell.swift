//
//  HomeFeatureCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeFeatureCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var reuseID = "HomeFeatureCell"
    var featureView: HomeFeatureView!
    
    //MARK: - UI Elements
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        makeShadow()
    }
    
    //MARK: - Methods
    func configureCell(){
        setupCardViewConstraints()
        
        featureView.customizeUI()
        
    }
    
    func setupCardViewConstraints(){
        featureView = HomeFeatureView()
        addSubview(featureView)
        featureView.translatesAutoresizingMaskIntoConstraints = false
        featureView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        featureView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        featureView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        featureView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.90).isActive = true
        
    }
    
    func makeShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 20.0
    }
    
    
}
