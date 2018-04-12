//
//  HomeViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit


protocol HomeFeatureDelegate: class {
    func didTapFeature(_ feature: HomeFeature?)
}

class HomeViewController: SNBaseViewController {

    //MARK: - Properties
    var homeView: HomeView!
    var homeState: HomeState?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PageTitles.home.rawValue
        
        fetchLinksData()
        configureHomeState()
        setupHomeView()
        
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        
        homeView.collectionView.register(HomeGreetingCollectionViewCell.self)
        homeView.collectionView.register(HomeFeatureCollectionViewCell.self)
        homeView.collectionView.register(HomeLinkCollectionViewCell.self)
        
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
    
  
    func configureHomeState(){
        if SCDatabaseQueryManager.savedFeatures().count != 0 && SCDatabaseQueryManager.getSavedLinks().count != 0 {
            self.homeState = HomeState.premium
        } else if SCDatabaseQueryManager.getSavedLinks().count == 0 && SCDatabaseQueryManager.savedFeatures().count > 0 {
            self.homeState = HomeState.featuresOnly
        } else if SCDatabaseQueryManager.getSavedLinks().count > 0 && SCDatabaseQueryManager.savedFeatures().count == 0 {
            self.homeState = HomeState.linksOnly
        } else {
            self.homeState = HomeState.basic
        }
    }
    
}

//MARK: - Network calls
extension HomeViewController {
    //update Links DB
    
    func fetchLinksData(){
        SCHomeLink.getHomeLinksForSchool(update: true)
    }
}

//MARK: - Feature Cell Selection Delegate
extension HomeViewController: HomeFeatureDelegate {
    
    func didTapFeature(_ feature: HomeFeature?) {
        guard let featureType = feature else { return }
        let featureVC = featureType.setFeatureView()
        featureVC.view.backgroundColor = UIColor.white
        show(featureVC, sender: nil)
    }
}

//MARK: - Collection Delegate
extension HomeViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let state = homeState else { return 1 }
        switch state {
        case .premium:
            return 3
        case .featuresOnly, .linksOnly:
            return 2
        case .basic:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == HomeCellIndex.greeting.rawValue {
            
            let cell: HomeGreetingCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
            cell.configureCell()
            return cell
            
        } else if indexPath.row == HomeCellIndex.featureCell.rawValue && SCDatabaseQueryManager.savedFeatures().count != 0 {
            
            let cell: HomeFeatureCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
            cell.configureCell()
            cell.featureCellDelegate = self
            return cell
            
        } else if indexPath.row == HomeCellIndex.linksCell.rawValue || SCDatabaseQueryManager.getSavedLinks().count != 0 {
            
            let cell: HomeLinkCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
            
            cell.configureCell()
        
            return cell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == HomeCellIndex.greeting.rawValue {
            return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.6)

        } else if indexPath.row == HomeCellIndex.featureCell.rawValue && SCDatabaseQueryManager.savedFeatures().count != 0 {
            
            return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.45)

        } else if indexPath.row == HomeCellIndex.linksCell.rawValue || SCDatabaseQueryManager.getSavedLinks().count != 0 {
            
            if SCDatabaseQueryManager.getSavedLinks().count > 3 {
                return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.44)
            }
            return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.3)
        }
        
        return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if indexPath.row == HomeCellIndex.greeting.rawValue {
                if let cell = collectionView.cellForItem(at: indexPath) {
                    cell.transform = .init(scaleX: 0.95, y: 0.95)
                    
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if indexPath.row == HomeCellIndex.greeting.rawValue {
                if let cell = collectionView.cellForItem(at: indexPath) {
                    cell.transform = .identity
                    
                }
            }
        }
    }
    
}




