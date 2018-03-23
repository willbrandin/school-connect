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
    
    
    //Search Properties
    var schoolList = [School]()
    var shouldShowSearchResults = false
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PageTitles.schoolSearch.rawValue
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
        searchView.customizeUI(shouldShowSearchResults)
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
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.cellId)

    }
    
    func setupNavBar(){
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.scGray()]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = UIColor.scGrayText()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
}

//MARK: - Search Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchBar.text as! String
        if str.count == 0 {
            shouldShowSearchResults = false
            self.schoolList.removeAll()
            self.searchView.tableView.reloadData()
            let newView = SearchBlankView()
            newView.customizeUI()
            self.searchView.tableView.separatorStyle  = .none
            self.searchView.tableView.backgroundView = newView
            
        } else if str.count > 2 {
            let strResult = str.removeSpecialCharactersFromText()
            shouldShowSearchResults = true
            self.searchView.tableView.backgroundView = nil
            self.searchView.tableView.separatorStyle = .singleLine

            School.fetchNames(input: strResult, completion: { (schools) in
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

//MARK: - TableView Delegates
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if schoolList.count > 0 {
            return schoolList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellId, for: indexPath) as? SearchTableViewCell
        if schoolList.count > 0 {
            cell?.configureCell(schoolList[indexPath.row])
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let confirmationVC = ConfirmationViewController()
        let selectedSchool = schoolList[indexPath.row]
        
        confirmationVC.selectedSchool = selectedSchool
        
        self.show(confirmationVC, sender: nil)
    }
    
}
