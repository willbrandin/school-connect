//
//  NewsArticleCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class NewsArticleCollectionViewCell: UICollectionViewCell, CellLoadableView, Shadowable {
    
    // MARK: - UI Elements

    var cardView: NewsCardView!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCardViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        makeShadow()
    }
    
    // MARK: - Methods
    
    func configureCell(_ article: NewsArticle?){
        if let news = article {
            cardView.newsArticle = news
            cardView.customizeUI()
        }
    }
    
    private func setupCardViewConstraints(){
        cardView = NewsCardView(frame: .zero)
        
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.90).isActive = true
    }
}
