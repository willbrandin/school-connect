//
//  CalendarView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    //MARK: - UI Elements
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl! = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        return refreshControl
    }()
    
    
    //MARK: - Init
    func customizeUI(){
        backgroundColor = UIColor.white
        setupTableViewConstraints()
    }
    
    //MARK: - Methods
    
    func setupTableViewConstraints(){
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupRefreshControl(){
        // Add Refresh Control to Table View
        tableView.refreshControl = refreshControl
    }
    
    @objc func handleRefresh(){
        refreshControl.beginRefreshing()
    }
}
