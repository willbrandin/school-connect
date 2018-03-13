//
//  SNTabBarController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewControllersAndAddNavigation()
    }

    func addViewControllers() -> [UIViewController]{
        let homeViewController = HomeViewController()
        homeViewController.view.backgroundColor = UIColor.blue
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        let newsViewController = HomeViewController()
        newsViewController.view.backgroundColor = UIColor.red
        newsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        let calendarViewController = HomeViewController()
        calendarViewController.view.backgroundColor = UIColor.blue
        calendarViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        let contactViewController = HomeViewController()
        contactViewController.view.backgroundColor = UIColor.red
        contactViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
        
        return [homeViewController, newsViewController, calendarViewController, contactViewController]
    }
    
    func mapViewControllersAndAddNavigation(){
        viewControllers = addViewControllers().map({ SNBaseNavigationController(rootViewController: $0) })
    }
    

}
