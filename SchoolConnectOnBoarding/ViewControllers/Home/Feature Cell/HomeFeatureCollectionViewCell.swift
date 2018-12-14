//
//  HomeFeatureCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeFeatureCollectionViewCell: UICollectionViewCell, CellLoadableView {
    
    //MARK: - Properties
    var collectionView: UICollectionView!
    var featureArray = [String]()
    weak var featureCellDelegate: HomeFeatureDelegate?
    
    //MARK: - UI Elements

    lazy var featureTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.heroTitle
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
        setArrayValue()
        setupTitleConstraints()
        setupCollectionViewConstraints()
        
        collectionView.register(FeatureCell.self, forCellWithReuseIdentifier: FeatureCell.reuseID)
    }
    
    func setArrayValue(){
//        featureArray = SCDatabaseQueryManager.savedFeatures() as! [String]
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
        return featureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FeatureCell = collectionView.deqeueReusableCell(for: indexPath)
        let enumCase = HomeFeature(rawValue: featureArray[indexPath.row])
        cell.configureCell(enumCase)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.90, height: self.frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFeature = featureArray[indexPath.row]
        let enumCase = HomeFeature(rawValue: selectedFeature)
        featureCellDelegate?.didTapFeature(enumCase)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .init(scaleX: 0.97, y: 0.97)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .identity
            }
        }
    }
    
}
