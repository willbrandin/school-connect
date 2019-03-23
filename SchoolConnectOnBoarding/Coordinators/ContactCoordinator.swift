//
//  ContactCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

final class ContactCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: SNTabBarOption.contact.title,
                            image: SNTabBarOption.contact.icon,
                            tag: 2)
    }
    
    private var contactViewController: ContactViewControllerProtocol?
    
    override func createMainViewController() -> UIViewController? {
        return createContactViewController()
    }
    
    private func createContactViewController() -> UIViewController? {
        contactViewController = ContactViewController()
        guard let controller = contactViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
}
