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

protocol HomeViewControllerProtocol: Presentable {
    var didSelectFeature: ((HomeFeature?) -> Void)? { get set }
    var didSelectLink: (() -> Void)? { get set }
}

class HomeViewController: SNBaseViewController, HomeViewControllerProtocol {

    // MARK: - Properties
    var homeView: HomeView!
    var homeState: HomeState?
    
    var viewModel: HomeViewModelProtocol
    
    var didSelectFeature: ((HomeFeature?) -> Void)?
    var didSelectLink: (() -> Void)?
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal: Coder not implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = PageTitles.home.rawValue
        view.backgroundColor = .white

        setupHomeView()
        
        subscribeToViewModel()
        viewModel.requestData()
        
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        
        homeView.collectionView.register(HomeGreetingCollectionViewCell.self)
        homeView.collectionView.register(HomeFeatureCollectionViewCell.self)
        homeView.collectionView.register(HomeLinkCollectionViewCell.self)
    }
    
    // MARK: - Methods
    private func setupHomeView(){
        homeView = HomeView()
        homeView.customizeUI()
        
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        homeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func subscribeToViewModel() {
        viewModel.onFetchedSchoolAndSettings = {
            DispatchQueue.main.async {
                self.homeView.collectionView.reloadData()
            }
        }
        
        viewModel.onNetworkingDidFail = { [weak self] error in
            self?.present(error.initAlert(), animated: true, completion: nil)
        }
    }
}

// MARK: - Feature Cell Selection Delegate
extension HomeViewController: HomeFeatureDelegate {
    
    func didTapFeature(_ feature: HomeFeature?) {
        guard let featureType = feature else { return }
        let featureVC = featureType.setFeatureView()
        featureVC.view.backgroundColor = UIColor.white
        show(featureVC, sender: nil)
    }
}

// MARK: - Collection Delegate
extension HomeViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInHomeCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == HomeCellIndex.greeting.rawValue {
            let cell: HomeGreetingCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
            cell.configureCell()
            
            return cell
        } else if indexPath.row == HomeCellIndex.featureCell.rawValue { //&& SCDatabaseQueryManager.savedFeatures().count != 0 {
            let cell: HomeFeatureCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
            cell.configureCell()
            cell.featureCellDelegate = self
            
            return cell
        } else if indexPath.row == HomeCellIndex.linksCell.rawValue { //|| SCDatabaseQueryManager.getSavedLinks().count != 0 {
            let cell: HomeLinkCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
            cell.configureCell()
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.layoutFor(indexPath, with: collectionView.frame.width)
    }
//
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.3) {
//            if indexPath.row == HomeCellIndex.greeting.rawValue {
//                if let cell = collectionView.cellForItem(at: indexPath) {
//                    cell.transform = .init(scaleX: 0.95, y: 0.95)
//                }
//            }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.3) {
//            if indexPath.row == HomeCellIndex.greeting.rawValue {
//                if let cell = collectionView.cellForItem(at: indexPath) {
//                    cell.transform = .identity
//
//                }
//            }
//        }
//    }
}
