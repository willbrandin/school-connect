//
//  ApplicationCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NavigationFlowCoordinator {
    
    deinit {
        print("Application Coordinator Deinit")
    }
    
    override func createMainViewController() -> UIViewController? {
        determineRootViewController()
        return nil
    }
    
    private func determineRootViewController() {
        if UserDefaultsManager.selectedUserSchoolId != nil && UserDefaultsManager.userSelectedSchool != nil {
            createHomeViewController()
        } else {
            createOnBoardingFlow()
        }
    }
    
    private func createHomeViewController() {
        let tabBarController = SNTabBarController()
        pushAndMakeRoot(viewController: tabBarController)
    }
    
    private func createOnBoardingFlow() {
        self.start(childCoordinator: OnBoardingCoordinator(), with: .pushAndMakeRoot)
    }
}
