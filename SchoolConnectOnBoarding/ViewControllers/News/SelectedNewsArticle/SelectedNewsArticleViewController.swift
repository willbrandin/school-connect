//
//  SelectedNewsArticleViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SelectedNewsArticleViewController: SNBaseViewController, Injectable {

    
    //MARK: - Properties
    var articleView: SelectedNewsArticleView!
    private var selectedArticle: NewsArticle?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEventView()
        setTitle()
    }
    
    init(selectedArticle: NewsArticle) {
        self.selectedArticle = selectedArticle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(_ article: NewsArticle) {
        self.selectedArticle = article
    }
    
    
    //MARK: - Methods
    func setupEventView(){
        articleView = SelectedNewsArticleView()
        articleView.customizeUI(selectedArticle)
        self.view.addSubview(articleView)
        
        articleView.translatesAutoresizingMaskIntoConstraints = false
        articleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        articleView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        articleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        articleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setTitle(){
        if let event = selectedArticle {
            self.title = event.title
        }
    }
    
}
