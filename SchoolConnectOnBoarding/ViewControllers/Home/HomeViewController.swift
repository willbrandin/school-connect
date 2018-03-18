//
//  HomeViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeViewController: SNBaseViewController {

    //MARK: - Properties
    var homeView: HomeView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        setupHomeView()
        
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        
        homeView.collectionView.register(HomeGreetingCollectionViewCell.self, forCellWithReuseIdentifier: HomeGreetingCollectionViewCell.reuseID)
        
        homeView.collectionView.register(HomeFeatureCollectionViewCell.self, forCellWithReuseIdentifier: HomeFeatureCollectionViewCell.reuseID)
        
        homeView.collectionView.register(HomeLinkCollectionViewCell.self, forCellWithReuseIdentifier: HomeLinkCollectionViewCell.reuseID)
    }
    
    
    //MARK: - Methods
    func setupHomeView(){
        homeView = HomeView()
        homeView.customizeUI()
        self.view.addSubview(homeView)
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

//MARK: - Collection Delegate
extension HomeViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == HomeCellIndex.greeting.rawValue {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGreetingCollectionViewCell.reuseID, for: indexPath) as! HomeGreetingCollectionViewCell
            cell.backgroundColor = UIColor.green
            return cell
            
        } else if indexPath.row == HomeCellIndex.featureCell.rawValue {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeatureCollectionViewCell.reuseID, for: indexPath) as! HomeFeatureCollectionViewCell
            cell.backgroundColor = UIColor.blue
            return cell
            
        } else if indexPath.row == HomeCellIndex.linksCell.rawValue {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeLinkCollectionViewCell.reuseID, for: indexPath) as! HomeLinkCollectionViewCell
            cell.backgroundColor = UIColor.red
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == HomeCellIndex.greeting.rawValue {
            return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.5)

        } else if indexPath.row == HomeCellIndex.featureCell.rawValue {
            return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.4)

        } else if indexPath.row == HomeCellIndex.linksCell.rawValue {
            return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.3)
        }
     
        return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.3)
    }
    
}
