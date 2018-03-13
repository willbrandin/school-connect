//
//  SNBaseNavigationController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SNBaseNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationAttributes()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Methods
    
    func setupNavigationAttributes() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationBar.titleTextAttributes = textAttributes
        self.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationBar.barTintColor = SNDatabaseQueryManager.getSavedPrimaryColor()
    }


}
