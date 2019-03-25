//
//  TabCoordinatable.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

protocol TabCoordinatable: class {
    var tabBarItem: UITabBarItem { get }
    var tabNavigationController: UIViewController? { get }
}
