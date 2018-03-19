//
//  HomeLinkCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeLinkCollectionViewCell: SCHomeCollectionViewCell {
    
    
    //MARK: - Properties
    static var reuseID = "HomeLinkCell"
    var linkView: HomeLinkView!
    
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

        linkView.customizeUI()
        
    }
    
    func setupCardViewConstraints(){
        linkView = HomeLinkView()
        addSubview(linkView)
        
        linkView.translatesAutoresizingMaskIntoConstraints = false
        linkView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        linkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        linkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        linkView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0).isActive = true
    }
    
    
}
