//
//  CalendarView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    //MARK: - Properties
    
    //MARK: - UI Elements
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.tag = 1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Init
    func customizeUI(){
        //
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
    
    
}
