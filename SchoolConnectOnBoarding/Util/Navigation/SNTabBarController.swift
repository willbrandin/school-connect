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
        homeViewController.tabBarItem = UITabBarItem(title: PageTitles.home.rawValue, image: UIImage.homeTabBarIcon(), tag: 0)
        
        let newsViewController = NewsViewController()
        newsViewController.tabBarItem = UITabBarItem(title: PageTitles.news.rawValue, image: UIImage.newsTabBarIcon(), tag: 1)
        
        let calendarViewController = CalendarViewController()
        calendarViewController.tabBarItem = UITabBarItem(title: PageTitles.calendar.rawValue, image: UIImage.calendarTabBarIcon(), tag: 2)
        
        let contactViewController = ContactViewController()
        contactViewController.tabBarItem = UITabBarItem(title: PageTitles.contact.rawValue, image: UIImage.contactTabBarIcon(), tag: 3)
        
        return [homeViewController, newsViewController, calendarViewController, contactViewController]
    }
    
    func mapViewControllersAndAddNavigation(){
        viewControllers = addViewControllers().map({ SNBaseNavigationController(rootViewController: $0) })
        self.tabBar.barTintColor = SCDatabaseQueryManager.getSavedPrimaryColor()
        //Active tab
        tabBar.tintColor = SCDatabaseQueryManager.getSavedSecondaryColor()
        
        if (tabBar.barTintColor?.isLight)! {
            tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            tabBar.unselectedItemTintColor = UIColor.lightGray
        }
    }
    

}
