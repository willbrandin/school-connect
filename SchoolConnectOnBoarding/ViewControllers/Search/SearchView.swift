//
//  SearchView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SearchView: UIView {

    // MARK: - Properties
    
    lazy var searchBar: UISearchBar! = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.barStyle = .default
        searchBar.isTranslucent = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.tag = 1
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Methods
    func customizeUI(_ showingCells: Bool) {
        backgroundColor = UIColor.white
        setupSearchBarConstraints()
        setupTableViewConstraints()
        if showingCells {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
            tableView.backgroundColor = UIColor.white
        } else {
            let newView = SearchBlankView()
            newView.customizeUI()
            tableView.separatorStyle  = .none
            tableView.backgroundView = newView
        }
    }
    
    func setupSearchBarConstraints(){
        addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupTableViewConstraints(){
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}
