//
//  HomeLinkCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeLinkCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    static var reuseID = "HomeLinkCell"
    var linkView: HomeLinkView!
    
    //MARK: - UI Elements
    
    lazy var linkTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.text = "Useful Links"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    //MARK: - Methods
    func configureCell(){
        setupTitleConstraints()
        setupCardViewConstraints()
        linkView.customizeUI()
        
    }
    
    func setupCardViewConstraints(){
        linkView = HomeLinkView()
        addSubview(linkView)
        
        linkView.translatesAutoresizingMaskIntoConstraints = false
        linkView.topAnchor.constraint(equalTo: self.linkTitleLabel.bottomAnchor, constant: 5.0).isActive = true
        linkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        linkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        linkView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0).isActive = true
    }
    
    func setupTitleConstraints(){
        addSubview(linkTitleLabel)
        linkTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
        linkTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        linkTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        linkTitleLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
    }
    
}
