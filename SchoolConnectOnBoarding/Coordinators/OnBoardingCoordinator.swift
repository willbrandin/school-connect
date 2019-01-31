//
//  OnBoardingCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

final class OnBoardingCoordinator: NavigationFlowCoordinator {
    
    private var splashViewController: LandingViewControllerProtocol?
    private var schoolSearchViewController: SchoolSearchViewControllerProtocol?
    private var confirmationViewController: ConfirmationViewController?
    
    override func createMainViewController() -> UIViewController? {
        return createSplashViewController()?.toPresent()
    }
    
    private func createSplashViewController() -> LandingViewControllerProtocol? {
        splashViewController = LandingViewController()
        splashViewController?.didTapToContinue = { [weak self] in
            self?.showSchoolSearchViewController()
        }
        return splashViewController
    }
    
    private func showSchoolSearchViewController() {
        let viewModel = SchoolSearchViewModel()
        schoolSearchViewController = SearchViewController(viewModel: viewModel)
        schoolSearchViewController?.didSelectSchoolId = { [weak self] id in
            self?.showSchoolConfirmationViewController(with: id)
        }
        guard let controller = schoolSearchViewController?.toPresent() else { return }
        push(viewController: controller)
    }
    
    private func showSchoolConfirmationViewController(with id: String) {
        let viewModel = ConfirmationViewModel(with: id)
        confirmationViewController = ConfirmationViewController(viewModel: viewModel)
        confirmationViewController?.didConfirmSchool = { [weak self] id in
            UserDefaultsManager.selectedUserSchoolId = id
            self?.send(flowEvent: FlowEventType.didSelectSchool)
        }
        guard let controller = confirmationViewController?.toPresent() else { return }
        push(viewController: controller)
    }
}
