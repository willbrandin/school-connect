//
//  HomeView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/16/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeView: UIView {

    //MARK: - Properties
    var collectionView: UICollectionView!
  
    //MARK: - UI Elements

    //MARK: - Init
    
    func customizeUI(){
        backgroundColor = SCColors.scBlue
        
        setupCollectionViewConstraints()
    }
    
    
    //MARK: - Methods
    func setupCollectionViewConstraints(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        collectionView.backgroundColor = UIColor.white
        
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
}
