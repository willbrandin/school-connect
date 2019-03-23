//
//  ConfirmationViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ConfirmationViewControllerProtocol: Presentable {
    var didConfirmSchool: ((String?) -> Void)? { get set }
}

class ConfirmationViewController: SNBaseViewController, ConfirmationViewControllerProtocol {

    //MARK: - Properties
    
    var confirmationView: ConfirmationView!
    var viewModel: ConfirmationViewModelProtocol
    
    var didConfirmSchool: ((String?) -> Void)?
    
    init(viewModel: ConfirmationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = PageTitles.confirmation.rawValue
        view.backgroundColor = .white
        setupConfirmationView()
        subscribeToViewModel()
        viewModel.requestSchoolDetails()
    }
    
    //MARK: - Methods
    
    private func subscribeToViewModel() {
        viewModel.onNetworkingDidFail = { [weak self] error in
            DispatchQueue.main.async {
                self?.present(error.initAlert(), animated: true, completion: nil)
            }
        }
        
        viewModel.onDidSetSchool = { [weak self] uiModel in
            DispatchQueue.main.async {
                self?.confirmationView.customizeUI(uiModel)
            }
        }
        
        viewModel.onNetworkLoading = { [weak self] in
            // isLoading
        }
    }
    
    private func setupConfirmationView(){
        confirmationView = ConfirmationView()
        
        confirmationView.didTapToConfirmSchool = { [weak self] in
            self?.didConfirmSchool?(self?.viewModel.schoolId)
        }
        
        view.addSubview(confirmationView)
        
        confirmationView.translatesAutoresizingMaskIntoConstraints = false
        confirmationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        confirmationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        confirmationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        confirmationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}
