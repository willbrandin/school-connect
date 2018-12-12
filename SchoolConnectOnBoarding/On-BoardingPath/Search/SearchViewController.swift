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
    
    //MARK: - Search Properties
    var schoolList = [SchoolSearch]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }
    
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
        searchView.tableView.register(SearchTableViewCell.self)
    }
    
    func setupNavBar(){
        let attributes = [NSAttributedStringKey.foregroundColor: SCColors.scGray]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        self.navigationController?.navigationBar.tintColor = SCColors.scGrayText
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: - Search Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchBar.text!
        if str.count == 0 {
            shouldShowSearchResults = false
            self.schoolList.removeAll()
            let newView = SearchBlankView()
            newView.customizeUI()
            self.searchView.tableView.separatorStyle  = .none
            self.searchView.tableView.backgroundView = newView
            
        } else if str.count > 2 {
            let strResult = str.removeSpecialCharactersFromText()
            shouldShowSearchResults = true
            self.searchView.tableView.backgroundView = nil
            self.searchView.tableView.separatorStyle = .singleLine

            fetchWithSearch(query: strResult)
        }
    }
    
    private func fetchWithSearch(query: String) {
        SchoolSearch.fetchList(with: query, completion: { result in
            switch result {
            case .success(let schools):
                if schools.count == 0 {
                    self.schoolList.removeAll()
                } else {
                    self.schoolList.removeAll()
                    self.schoolList = schools
                }
            case .error:
                DispatchQueue.main.async {
                    let alert = SCErrors.fetchError.initAlert()
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
    
    private func fetchSelectedSchool(with schoolId: String?, completion: @escaping (School?) -> Void){
        School.fetchDetails(with: schoolId) { result in
            switch result {
            case .success(let school):
                completion(school)
            case .error:
                DispatchQueue.main.async {
                    let alert = SCErrors.fetchError.initAlert()
                    self.present(alert, animated: true, completion: nil)
                }
            }
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
        let cell: SearchTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        
        if schoolList.count > 0 {
            cell.configureCell(schoolList[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSchool = schoolList[indexPath.row]
        
        fetchSelectedSchool(with: selectedSchool.id) { (selectedSchoolData) in
            guard let school = selectedSchoolData else { return }
            
            DispatchQueue.main.async {
                let confirmationVC = ConfirmationViewController(selectedSchool: school)
                self.show(confirmationVC, sender: nil)
            }
        }
    }
    
}
