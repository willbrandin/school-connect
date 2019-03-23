//
//  HomeCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

class HomeCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: SNTabBarOption.home.title,
                                                image: SNTabBarOption.home.icon,
                                                tag: 0)
    }
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    private var homeViewController: HomeViewControllerProtocol?
    
    override func createMainViewController() -> UIViewController? {
        return createHomeViewController()
    }
    
    private func createHomeViewController() -> UIViewController? {
        guard let id = UserDefaultsManager.selectedUserSchoolId else { return nil }
        homeViewController = HomeViewController(viewModel: HomeViewModel(schoolId: id))
        guard let controller = homeViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
}
