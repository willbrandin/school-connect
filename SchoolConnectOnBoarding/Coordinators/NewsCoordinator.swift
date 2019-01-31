//
//  NewsCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

final class NewsCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    var rootViewController: UIViewController? {
        return mainViewController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: SNTabBarOption.news.title,
                            image: SNTabBarOption.news.icon,
                            tag: 1)
    }
    
    private var newsViewController: NewsViewControllerProtocol?
    
    override init() {
        super.init()
        
        start(with: .present, animated: false)
    }
    
    override func createMainViewController() -> UIViewController? {
        return createNewsViewController()
    }
    
    private func createNewsViewController() -> UIViewController? {
        newsViewController = NewsViewController()
        newsViewController?.onDidSelectNewsArticle = { article in
            
        }
        guard let controller = newsViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
}
