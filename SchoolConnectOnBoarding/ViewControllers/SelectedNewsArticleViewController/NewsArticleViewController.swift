//
//  SelectedNewsArticleViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class NewsArticleViewController: SNBaseViewController, NewsArticleViewControllerProtocol {

    // MARK: - Properties
    var articleView: NewsArticleView!
    private var selectedArticle: NewsArticle?
    
    // MARK: - NewsArticleViewControllerProtocol
    var onTapToClose: (() -> Void)?
    
    // MARK: - Life Cycle
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

    // MARK: - Methods
    func setupEventView(){
        articleView = NewsArticleView()
        articleView.customizeUI(selectedArticle)
        
        view.addSubview(articleView)
        articleView.pinToSuperview()
        
        articleView.onTapToDismiss = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    func setTitle(){
        if let event = selectedArticle {
            title = event.title
        }
    }
}
