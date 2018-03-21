//
//  NewsArticleCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class NewsArticleCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var reuseID = CellReuseIds.newsArticleCardCell.rawValue
    var cardView: NewsCardView!
    
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
    func configureCell(_ article: NewsArticle?){
        setupCardViewConstraints()
        if let news = article {
            cardView.newsArticle = news
            cardView.customizeUI()
        }
    }
    
    func setupCardViewConstraints(){
        cardView = NewsCardView()
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.90).isActive = true

    }
    
    func makeShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 20.0
    }
    
    
}







