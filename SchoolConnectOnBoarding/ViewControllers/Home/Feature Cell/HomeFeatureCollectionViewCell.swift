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
    var collectionView: UICollectionView!

    
    
    //MARK: - UI Elements

    lazy var featureTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.text = "Features"
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
        setupCollectionViewConstraints()
        
        collectionView.register(FeatureCell.self, forCellWithReuseIdentifier: FeatureCell.reuseID)
    }
    
    func setupCollectionViewConstraints(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.topAnchor.constraint(equalTo: featureTitleLabel.bottomAnchor, constant: 5.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupTitleConstraints(){
        addSubview(featureTitleLabel)
        featureTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 35.0).isActive = true
        featureTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        featureTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        featureTitleLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
    }
    
    
}

extension HomeFeatureCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCell.reuseID, for: indexPath) as! FeatureCell
        
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width * 0.90, height: self.frame.height * 0.75)

    }
    
    
}
