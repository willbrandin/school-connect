//
//  NewsView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class NewsView: UIView {
    
    // MARK: - Closures
    var onRefresh: (() -> Void)?
    
    // MARK: - Properties
    
    var collectionViewLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
    
    lazy var collectionView: UICollectionView! = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var refreshControl: UIRefreshControl! = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(collectionView)
        collectionView.pinToSuperview()
        collectionView.refreshControl = refreshControl
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    @objc private func handleRefresh(){
        onRefresh?()
    }
}
