//
//  NewsArticleCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeGreetingCollectionViewCell: SCHomeCollectionViewCell, CellLoadableView {
    
    //MARK: - Properties
    static var reuseID = CellReuseIds.homeGreetingCollectionCell.rawValue
    var greetingView: HomeGreetingView!
    
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
        
        greetingView.customizeUI()
    }
    
    func setupCardViewConstraints(){
        greetingView = HomeGreetingView()
        addSubview(greetingView)
        greetingView.translatesAutoresizingMaskIntoConstraints = false
        greetingView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        greetingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        greetingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        greetingView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
        
    }
   
}
