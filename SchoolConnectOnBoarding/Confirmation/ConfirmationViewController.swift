//
//  ConfirmationViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

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
        self.view.addSubview(confirmationView)
        
        confirmationView.translatesAutoresizingMaskIntoConstraints = false
        confirmationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        confirmationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        confirmationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        confirmationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    

}
