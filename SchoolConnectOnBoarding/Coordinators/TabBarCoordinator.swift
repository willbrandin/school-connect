//
//  TabBarCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

final class TabBarCoordinator: NavigationFlowCoordinator, SchoolColorable {
    
    private var tabBarController = UITabBarController()
    private var homeCoordinator = HomeCoordinator()
    private var newsCoordinator = NewsCoordinator()
    private var calendarCoordinator = CalendarCoordinator()
    private var contactCoordinator = ContactCoordinator()

    override func createMainViewController() -> UIViewController? {
        setupCoordinators()
        return tabBarController
    }
    
    private func setupCoordinators() {
        setupHomeCoordinator()
        setupNewsCoordinator()
        setupCalendarCoordinator()
        setupContactCoordinator()
    }
    
    private func setupHomeCoordinator() {
        homeCoordinator.start()
        guard let controller = homeCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers = [controller]
    }
    
    private func setupNewsCoordinator() {
        newsCoordinator.start()
        guard let controller = newsCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
    
    private func setupCalendarCoordinator() {
        calendarCoordinator.start()
        guard let controller = calendarCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
    
    private func setupContactCoordinator() {
        contactCoordinator.start()
        guard let controller = contactCoordinator.tabNavigationController else { return }
        tabBarController.viewControllers?.append(controller)
    }
}
