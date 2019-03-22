//
//  ApplicationCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NavigationFlowCoordinator {

    override func handle(flowEvent: FlowEvent) -> Bool {
        guard let event = flowEvent as? FlowEventType else { return false }
        switch event {
        case .didSelectSchool:
            createHomeViewController()
            return true
        }
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
        let coordinator = TabBarCoordinator()
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.start(childCoordinator: coordinator, with: .pushAndMakeRoot)
    }
    
    private func createOnBoardingFlow() {
        self.start(childCoordinator: OnBoardingCoordinator(), with: .pushAndMakeRoot)
    }
}
