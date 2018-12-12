//
//  AppDelegate.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let defaults = UserDefaults.standard
        
        let schoolIsChosen = defaults.bool(forKey: UserDefaultKeys.schoolChosen.rawValue)
        let schoolId = defaults.string(forKey: UserDefaultKeys.selectedId.rawValue)

        if schoolIsChosen && schoolId != nil {
            if let id = schoolId {
                let tabBarController = SNTabBarController()
                var schoolToUpdate = School()
                School.fetchDetails(with: id) { (result) in
                    switch result {
                    case .success(let school):
                        schoolToUpdate = school
                    default:
                        break
                    }
                }
                SNAppSettings.fetchAppConfigSettings(with: id)
                schoolToUpdate.saveSchoolDetails(update: true)
                self.window?.rootViewController = tabBarController
            }
            
        } else {
            let landingVC = LandingViewController()
            let nav = UINavigationController(rootViewController: landingVC)
            nav.navigationBar.isHidden = true
            window?.rootViewController = nav
        }
    
        window!.makeKeyAndVisible()
      
        return true
    }

}
