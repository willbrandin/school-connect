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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.white
        setupSearchBarConstraints()
        setupTableViewConstraints()
    }
    
    // MARK: - Private Methods
   
    private func setupSearchBarConstraints(){
        addSubview(searchBar)
        searchBar.pinToTopSafeArea()
        searchBar.pinToLeadingAndTrailing()
    }
    
    private func setupTableViewConstraints(){
        addSubview(tableView)
        tableView.pinBelowView(view: searchBar)
        tableView.pinToBottomSafeArea()
        tableView.pinToLeadingAndTrailing()
    }
}
