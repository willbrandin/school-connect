//
//  CalendarView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    // MARK: - Closures
    var onRefresh: (() -> Void)?
    
    // MARK: - UI Elements
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl! = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        
        addSubview(tableView)
        tableView.pinToSuperview()
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Private Methods
    
    @objc private func handleRefresh(){
        onRefresh?()
    }
}
