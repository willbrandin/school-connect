//
//  LandingViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol LandingViewControllerProtocol: Presentable {
    var didTapToContinue: (() -> Void)? { get set }
}

class LandingViewController: UIViewController, LandingViewControllerProtocol {

    //MARK - Properties
    var landingView: LandingScreenView!
    var didTapToContinue: (() -> Void)?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLandingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    //MARK: - Methods
    func setupLandingView(){
        landingView = LandingScreenView()
        landingView.didTapToContinue = { [weak self] in
            self?.didTapToContinue?()
        }
        landingView.customizeUI()
        self.view.addSubview(landingView)
        
        landingView.translatesAutoresizingMaskIntoConstraints = false
        landingView.pinToSuperview()
    }
}
