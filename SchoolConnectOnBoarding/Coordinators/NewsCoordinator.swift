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
        return UITabBarItem(title: PageTitles.news.rawValue,
                            image: SCImages.TabBarImages.newsIcon,
                            tag: 1)
    }
    
    override func createMainViewController() -> UIViewController? {
        return createNewsViewController()
    }
    
    private func createNewsViewController() -> UIViewController? {
        let newsViewController = NewsViewController()
        newsViewController.tabBarItem = tabBarItem
        return newsViewController
    }
}
