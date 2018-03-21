//
//  ConfirmationViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ConfirmationDelegate: class {
    func didConfirmSchool()
}

class ConfirmationViewController: UIViewController {

    //MARK: - Properties
    
    var confirmationView: ConfirmationView!
    var selectedSchool: School!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PageTitles.confirmation.rawValue
        setupConfirmationView()
    }
    
    deinit {
        print("deinit")
    }
    
    
    //MARK: - Methods
    
    func setupConfirmationView(){
        confirmationView = ConfirmationView()
        confirmationView.customizeUI(selectedSchool)
        confirmationView.confirmationDelegate = self
        self.view.addSubview(confirmationView)
        
        confirmationView.translatesAutoresizingMaskIntoConstraints = false
        confirmationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        confirmationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        confirmationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        confirmationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

extension ConfirmationViewController: ConfirmationDelegate {
    
    func didConfirmSchool() {
        let defaults = UserDefaults.standard

        defaults.set(selectedSchool.schoolId, forKey: UserDefaultKeys.selectedId.rawValue)
        defaults.set(true, forKey: UserDefaultKeys.schoolChosen.rawValue)
        School.getSchoolDetailsWithId(update: false) { (completed) in
            
            if completed {
                
                SCHomeLink.getHomeLinksForSchool(update: false, completion: { (didFinish) in
                    if didFinish {
                        
                        let tabBarController = SNTabBarController()
                        self.navigationController?.setViewControllers([tabBarController], animated: true)
                        self.navigationController?.popToViewController(tabBarController, animated: true)
                        tabBarController.navigationController?.navigationBar.isHidden = true
                    }
                })
                
            }
        }
        
        
    }
    
    
}
