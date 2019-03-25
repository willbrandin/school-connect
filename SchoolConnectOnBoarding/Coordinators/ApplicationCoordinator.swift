//
//  ApplicationCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: NavigationFlowCoordinator {

    // MARK: - Flow Events
    
    override func handle(flowEvent: FlowEvent) -> Bool {
        guard let event = flowEvent as? FlowEventType else { return false }
        switch event {
        case .didSelectSchool:
            createHomeViewController()
            return true
        }
    }
    
    // MARK: - createMainViewController
    
    override func createMainViewController() -> UIViewController? {
        determineRootViewController()
        return nil
    }
    
    // MARK: - Private Methods
    
    private func determineRootViewController() {
        if UserDefaultsManager.selectedUserSchoolId != nil && UserDefaultsManager.userSelectedSchool != nil {
            createHomeViewController()
        } else {
            createOnBoardingFlow()
        }
    }
    
    private func createHomeViewController() {
        let coordinator = TabBarCoordinator()
        navigationController.setNavigationBarHidden(true, animated: false)
        start(childCoordinator: coordinator, with: .pushAndMakeRoot)
    }
    
    private func createOnBoardingFlow() {
        start(childCoordinator: OnBoardingCoordinator(), with: .pushAndMakeRoot)
    }
}
