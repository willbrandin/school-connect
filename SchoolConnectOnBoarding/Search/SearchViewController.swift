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
    let cellID = "SchoolNameCell"
    
    
    //Search Properties
    var schoolList = [SchoolSearch]()
    var filteredSchoolList = [SchoolSearch]()
    var shouldShowSearchResults = false
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupLandingView()
        setDelegates()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.searchBar.becomeFirstResponder()
    }
    
    //MARK: - Methods
    func setupLandingView(){
        searchView = SearchView()
        searchView.customizeUI()
        self.view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setDelegates() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.searchBar.delegate = self
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: cellID)

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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchBar.text as! String
        if str.count == 0 {
            
            self.schoolList.removeAll()
            self.searchView.tableView.reloadData()
            
        } else if str.count > 2 {
            let strResult = str.removeSpecialCharactersFromText()
            
            SchoolSearch.fetchNames(input: strResult, completion: { (schools) in
                if schools.count == 0 {
                    self.schoolList.removeAll()
                    self.searchView.tableView.reloadData()
                } else {
                    self.schoolList.removeAll()
                    self.schoolList = schools
                    self.searchView.tableView.reloadData()
                }
            })
        }

    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if schoolList.count > 0 {
            return schoolList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? SearchTableViewCell
        if schoolList.count > 0 {
            cell?.configureCell(schoolList[indexPath.row])

        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //cell height 1/6th of the phone screen
//        return self.view.frame.height * 0.10
//    }
    
}
