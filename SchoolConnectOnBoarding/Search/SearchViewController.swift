//
//  SearchViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK - Properties
    var searchView: SearchView!
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupLandingView()
        
    }
    
    //MARK: - Methods
    func setupLandingView(){
        searchView = SearchView()
        searchView.customizeUI()
        self.view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupNavBar(){
        self.title = "School Search"
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.scGray()]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = UIColor.scGrayText()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
