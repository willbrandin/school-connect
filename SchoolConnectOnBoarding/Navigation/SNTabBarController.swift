//
//  SNTabBarController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SNTabBarController: UITabBarController, SchoolColorable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setColors(){
        self.tabBar.barTintColor = schoolPrimaryColor
        tabBar.tintColor = schoolSecondaryColor
        
        if (tabBar.barTintColor?.isLight)! {
            tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            tabBar.unselectedItemTintColor = UIColor.lightGray
        }
    }

}

