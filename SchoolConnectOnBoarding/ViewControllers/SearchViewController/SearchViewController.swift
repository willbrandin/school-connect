//
//  SearchViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol SchoolSearchViewControllerProtocol: Presentable {
    var didSelectSchoolId: ((String) -> Void)? { get set }
}

class SearchViewController: SNBaseViewController, SchoolSearchViewControllerProtocol {

    // MARK - Properties
    
    var searchView: SearchView!
    var viewModel: SchoolSearchViewModelProtocol
    
    var didSelectSchoolId: ((String) -> Void)?
    
    var schoolList = [SchoolSearch]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.tableView.reloadData()
            }
        }
    }
    
    var shouldShowSearchResults = false
    
    // MARK: - Init
    
    init(viewModel: SchoolSearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = PageTitles.schoolSearch.rawValue
        
        setupLandingView()
        setEmptyState()
        setDelegates()
        subscribeToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchView.searchBar.becomeFirstResponder()
    }
    
    // MARK: - Private Methods
    
    private func setupLandingView(){
        searchView = SearchView()
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.pinToSuperview()
    }
    
    private func subscribeToViewModel() {
        viewModel.onNetworkingDidFail = { [weak self] error in
            self?.present(error.initAlert(), animated: true, completion: nil)
        }
        
        viewModel.onDidSetSchools = { [weak self] in
            DispatchQueue.main.async {
                self?.searchView.tableView.backgroundView = nil
                self?.searchView.tableView.separatorStyle = .singleLine
                self?.searchView.tableView.reloadData()
            }
        }
        
        viewModel.onDisplayNoSchools = { [weak self] in
            DispatchQueue.main.async {
                self?.setEmptyState()
            }
        }
    }
    
    private func setDelegates() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.searchBar.delegate = self
        searchView.tableView.register(SearchTableViewCell.self)
    }
    
    private func setEmptyState() {
        let newView = SearchBlankView()
        searchView.tableView.separatorStyle  = .none
        searchView.tableView.backgroundView = newView
        searchView.tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchBar.text!
        viewModel.determineFetch(for: searchText)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        cell.configureCell(viewModel.schoolName(for: indexPath))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let id = viewModel.schoolId(for: indexPath) else { return }
        didSelectSchoolId?(id)
    }
}
