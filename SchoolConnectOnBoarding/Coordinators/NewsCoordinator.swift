//
//  NewsCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

final class NewsCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    private var newsViewController: NewsViewControllerProtocol?
    private var newsArticleViewController: NewsArticleViewControllerProtocol?
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: SNTabBarOption.news.title,
                            image: SNTabBarOption.news.icon,
                            tag: 1)
    }
    
    override func createMainViewController() -> UIViewController? {
        return createNewsViewController()
    }
    
    private func createNewsViewController() -> UIViewController? {
        newsViewController = NewsViewController()
        newsViewController?.onDidSelectNewsArticle = { [weak self] article in
            self?.showNewsArticleViewController(with: article)
        }
        guard let controller = newsViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
    
    private func showNewsArticleViewController(with article: NewsArticle?) {
        guard let newsArticle = article else { return }
        newsArticleViewController = NewsArticleViewController(selectedArticle: newsArticle)
        newsArticleViewController?.onTapToClose = { [weak self] in
            self?.dismissLastViewController()
        }
        guard let controller = newsArticleViewController?.toPresent() else { return }
        present(viewController: controller)
    }
}
