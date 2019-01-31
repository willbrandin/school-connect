//
//  AppDelegate.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupKeyboard()
        configureNetworkEnvironment()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        applicationCoordinator = ApplicationCoordinator()
        applicationCoordinator?.start(with: .push, animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = applicationCoordinator?.navigationController
        window?.makeKeyAndVisible()
      
        return true
    }

}
