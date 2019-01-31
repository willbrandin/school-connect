//
//  HomeCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

protocol TabCoordinatable: class {
    var tabBarItem: UITabBarItem { get }
    var rootViewController: UIViewController? { get }
}

class HomeCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: PageTitles.home.rawValue,
                                                image: SCImages.TabBarImages.homeIcon,
                                                tag: 0)
    }
    
    var rootViewController: UIViewController? {
        return mainViewController
    }
    
    override func createMainViewController() -> UIViewController? {
        return createHomeViewController()
    }
    
    private func createHomeViewController() -> UIViewController {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = tabBarItem
        return homeViewController
//            SNBaseNavigationController(rootViewController: homeViewController)
    }
}
