//
//  NewsViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/30/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import Foundation

protocol NewsViewModelProtocol: class {
    var onNewsItemSelected:((NewsArticle) -> Void)? { get set }
    var onReceivedNews: (() -> Void)? { get set }
    var onNetworkIsLoading: ((Bool) -> Void)? { get set }
    var onErrorReceived: (() -> Bool)? { get set }
    
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: Int) -> Int
    func cellViewModel(for indexPath: IndexPath) -> String?
    func requestSchoolNews()
    func didSelectItem(at indexPath: IndexPath)
    func newsArticle(for indexPath: IndexPath) -> NewsArticle?
}

final class NewsViewModel: NewsViewModelProtocol {
    
    // MARK: - Properties
    var onNewsItemSelected: ((NewsArticle) -> Void)?
    var onReceivedNews: (() -> Void)?
    var onNetworkIsLoading: ((Bool) -> Void)?
    var onErrorReceived: (() -> Bool)?
    
    var numberOfSections: Int {
        return 1
    }
    
    private var newsArticles: [NewsArticle] = [] {
        didSet {
            onReceivedNews?()
        }
    }
    
    // MARK: - Methods
    func requestSchoolNews() {
        let id = UserDefaultsManager.selectedUserSchoolId ?? ""
        let endpoint = SchoolConnectAPI.news(id: id)
        
        requestNews(with: endpoint)
    }
    
    func numberOfRows(in section: Int) -> Int {
        return newsArticles.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> String? {
        return nil
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let selectedArticle = newsArticles[indexPath.row]
        onNewsItemSelected?(selectedArticle)
    }
    
    func newsArticle(for indexPath: IndexPath) -> NewsArticle? {
        return newsArticles[indexPath.row]
    }
    
    // MARK: - Private Methods
    private func requestNews(with endpoint: SchoolConnectAPI) {
        let networkManager = NetworkManager.sharedInstance
        networkManager.requestWithListResponse(for: endpoint, [NewsArticle].self) { [weak self] (result) in
            switch result {
            case .success(let news):
                self?.newsArticles = news
            case .error:
                break
            }
        }
    }
}
