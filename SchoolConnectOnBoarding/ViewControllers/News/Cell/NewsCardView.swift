//
//  NewsCardView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class NewsCardView: UIView {

    //MARK: - Properties
    var newsArticle: NewsArticle?
    
    //MARK: - UI Elements
    var newsImgView: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = UIImage.landingPageIcon()
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var pubDateLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26.0, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        label.textColor = UIColor.scGrayText()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - StackView
    
    lazy var bodyTextStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(pubDateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)

        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Init
    func customizeUI(){
        backgroundColor = UIColor.white
        setupStackViewContraints()
        
        if let news = newsArticle {
            pubDateLabel.text = news.pubDate?.stringWithDateFormat(.simpleDate)
            titleLabel.text = news.title
            subTitleLabel.text = news.subtitle

        }
        
    }
    override func layoutSubviews() {
        makeRoundCorners()
    }
    
    //MARK: - Methods
    func setupImageConstraints(){
        addSubview(newsImgView)
        newsImgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        newsImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        newsImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        newsImgView.bottomAnchor.constraint(equalTo: bodyTextStackView.topAnchor, constant: -16.0).isActive = true
    }
    
    func setupStackViewContraints(){
        addSubview(bodyTextStackView)
        
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50.0).isActive = true
        bodyTextStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0).isActive = true
        bodyTextStackView.heightAnchor.constraint(equalToConstant: 95.0).isActive = true
        
        setupImageConstraints()
        setupTitleLabelConstraints()
    }
    
    func setupTitleLabelConstraints(){
        titleLabel.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
    }
    
    func makeRoundCorners(){
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
    }
    
    

}
