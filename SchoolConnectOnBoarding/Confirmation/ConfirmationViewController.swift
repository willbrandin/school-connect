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
        self.title = "Confirm"
        setupConfirmationView()
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
        let vc = UIViewController()
        vc.navigationController?.navigationBar.isHidden = true
        vc.view.backgroundColor = UIColor.red

        defaults.set(selectedSchool.schoolId, forKey: "selectedSchoolId")
        defaults.set(true, forKey: "schoolIsChosen")
        self.show(vc, sender: nil)
    }
    
    
}
