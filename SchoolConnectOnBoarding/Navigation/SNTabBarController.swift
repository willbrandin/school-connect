//
//  SNTabBarController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class TabBarCoordinator: NavigationFlowCoordinator {
    
    private var tabBarViewControllers = [UIViewController]()
    private var tabBarController: SNTabBarController?
    
    override func createMainViewController() -> UIViewController? {
        return setupTabBarController()
    }
    
    private func setupTabBarController() -> SNTabBarController? {
        tabBarController = SNTabBarController()
        setupHomeCoordinator()
        return tabBarController
    }
//
//    private func addViewControllers() -> [UIViewController]{
//        let homeViewController = HomeViewController()
//        homeViewController.tabBarItem = UITabBarItem(title: PageTitles.home.rawValue,
//                                                     image: SCImages.TabBarImages.homeIcon,
//                                                     tag: 0)
//
//        let newsViewController = NewsViewController()
//        newsViewController.tabBarItem = UITabBarItem(title: PageTitles.news.rawValue,
//                                                     image: SCImages.TabBarImages.newsIcon,
//                                                     tag: 1)
//
//        let calendarViewController = CalendarViewController()
//        calendarViewController.tabBarItem = UITabBarItem(title: PageTitles.calendar.rawValue,
//                                                         image: SCImages.TabBarImages.calendarIcon,
//                                                         tag: 2)
//
//        let contactViewController = ContactViewController()
//        contactViewController.tabBarItem = UITabBarItem(title: PageTitles.contact.rawValue,
//                                                        image: SCImages.TabBarImages.contactIcon
//            ,
//                                                        tag: 3)
//        return [homeViewController, newsViewController, calendarViewController, contactViewController]
//    }
    
    private func setupHomeCoordinator() {
        let home = HomeCoordinator()
        start(childCoordinator: home, with: .present)
        let news = NewsCoordinator()
        start(childCoordinator: news, with: .present)
        tabBarController?.viewControllers = [home.rootViewController!, news.mainViewController!]
    }
    
}

class SNTabBarController: UITabBarController, SchoolColorable {
    func setColors(){
        tabBar.barTintColor = schoolPrimaryColor
        tabBar.tintColor = schoolSecondaryColor
        
        if tabBar.barTintColor?.isLight ?? false {
            tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            tabBar.unselectedItemTintColor = UIColor.lightGray
        }
    }
}
