//
//  NewsViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol NewsViewControllerProtocol: Presentable {
    var onDidSelectNewsArticle: ((NewsArticle?) -> Void)? { get set }
}

class NewsViewController: SNBaseViewController, NewsViewControllerProtocol {
    
    //MARK: - Properties
    var newsView: NewsView!
    
    var onDidSelectNewsArticle: ((NewsArticle?) -> Void)?
    
    private var viewModel: NewsViewModelProtocol = NewsViewModel()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = PageTitles.news.rawValue
        
        setupCustomView()
        
        newsView.collectionView.dataSource = self
        newsView.collectionView.delegate = self
        newsView.collectionView.register(NewsArticleCollectionViewCell.self)
        
        subscribeToViewModel()
    }
    
    //MARK: - Methods
    func setupCustomView(){
        newsView = NewsView()
        newsView.customizeUI()
        self.view.addSubview(newsView)
        
        newsView.translatesAutoresizingMaskIntoConstraints = false
        newsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        newsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        newsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        newsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Private Methods
    private func subscribeToViewModel() {
        viewModel.onNewsItemSelected = onDidSelectNewsArticle
        viewModel.onReceivedNews = { [weak self] in
            DispatchQueue.main.async {
                self?.newsView.collectionView.reloadData()
            }
        }
        viewModel.requestSchoolNews()
    }
}

//MARK: - Delegate
extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NewsArticleCollectionViewCell = collectionView.deqeueReusableCell(for: indexPath)
        cell.configureCell(viewModel.newsArticle(for: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: self.view.frame.height * 0.58)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsArticleCollectionViewCell {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsArticleCollectionViewCell {
                cell.transform = .identity
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}
