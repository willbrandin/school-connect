//
//  SCTabBarController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCTabBarController: UITabBarController, SchoolColorable {

    override func viewDidLoad() {
        super.viewDidLoad()

        setColors()
    }

    func setColors(){
        tabBar.barTintColor = schoolPrimaryColor
        tabBar.tintColor = schoolSecondaryColor

        if schoolPrimaryColor?.isLight ?? false {
            tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            tabBar.unselectedItemTintColor = UIColor.lightGray
        }
    }
}
