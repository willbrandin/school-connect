//
//  TabBarCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

final class TabBarCoordinator: NavigationFlowCoordinator {
    
    private var tabBarController = UITabBarController()
    
    override func createMainViewController() -> UIViewController? {
        setupHomeCoordinator()
        setupNewsCoordinator()
        return tabBarController
    }
    
    private func setupHomeCoordinator() {
        let coordinator = HomeCoordinator()
        guard let controller = coordinator.rootViewController else { return }
        tabBarController.viewControllers = [controller]
    }
    
    private func setupNewsCoordinator() {
        let coordinator = NewsCoordinator()
        guard let controller = coordinator.rootViewController else { return }
        tabBarController.viewControllers?.append(controller)
    }
}
