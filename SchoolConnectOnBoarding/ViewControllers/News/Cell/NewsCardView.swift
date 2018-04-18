//
//  NewsCardView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class NewsCardView: UIView, CornerRoundable {

    //MARK: - Properties
    var newsArticle: NewsArticle?
    
    //MARK: - UI Elements
    var newsImgView: UIImageView! = {
        let imageView = UIImageView()
        //imageView.image = SCImages.OnBoardingImages.landingPageIcon
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var pubDateLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.dateSubTitle
        label.textColor = SCColors.scGrayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.title
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.altBodyText
        label.textColor = SCColors.scGrayText
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

        stackView.distribution = .fillProportionally
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
            let url = URL(string: news.imgUrl!)
            self.newsImgView.kf.setImage(with: url)
        }
        
    }
    override func layoutSubviews() {
        roundCorners()
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
        
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50.0).isActive = true
        bodyTextStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0).isActive = true
        bodyTextStackView.heightAnchor.constraint(equalToConstant: 115.0).isActive = true
        
        setupImageConstraints()
        setupTitleLabelConstraints()
    }
    
    func setupTitleLabelConstraints(){
        //titleLabel.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
    }
    
   

}
