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

class ConfirmationViewController: SNBaseViewController {

    //MARK: - Properties
    
    var confirmationView: ConfirmationView!
    private let selectedSchool: School!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PageTitles.confirmation.rawValue
        setupConfirmationView()
    }
    
    init(selectedSchool: School) {
        self.selectedSchool = selectedSchool
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        setUserDefaults()
        fetchSchoolData()
    }
    
    func setUserDefaults(_ withoutError: Bool = true){
        let defaults = UserDefaults.standard
        
        defaults.set(selectedSchool.schoolId, forKey: UserDefaultKeys.selectedId.rawValue)
        defaults.set(withoutError, forKey: UserDefaultKeys.schoolChosen.rawValue)
    }
    
    
    func fetchSchoolData(){
        selectedSchool.saveSchoolDetails(update: false) { (completed) in
            if completed {
                self.fetchSchoolAppConfig()
            }
        }
    }
    
    func fetchSchoolAppConfig(){
        SNAppSettings.fetchAppConfigSettings(with: selectedSchool.schoolId, update: false) { (isComplete) in
            if isComplete {
                self.getLinksData()
            }
        }
    }
    
    func getLinksData(){
        
        SCHomeLink.fetchHomeLinks(with: selectedSchool.schoolId, update: false) { (didFinish, err) in
            if err != nil && !didFinish {
                
                DatabaseManager.removeSchools()
                self.setUserDefaults(false)
                
                DispatchQueue.main.async {
                    let alert = SCErrors.confirmationError.initAlert()
                    self.present(alert, animated: true, completion: nil)
                }
                
            } else if didFinish {
                self.presentHomeView()
            }
        }
    }
    
    func presentHomeView(){
        
        let tabBarController = SNTabBarController()
        self.navigationController?.dismiss(animated: true, completion: nil)
        present(tabBarController, animated: true, completion: nil)
    }
    
}
