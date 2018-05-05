//
//  FeatureCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/19/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class FeatureCell: SCHomeCollectionViewCell, CellLoadableView {
    
    
    //MARK: - Properties
    var cardView: FeatureCardView!
    static var reuseID = CellReuseIds.featureCollectionCell.rawValue
    
    
    //MARK: - UI Elements
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    //MARK: - Methods
    func configureCell(_ feature: HomeFeature?){
        setupCardViewConstraints()
        guard let featureType = feature else { return }
        cardView.customizeUI(featureType)
        //cardView.customizeUI(HomeFeature.bullyReporting)
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
