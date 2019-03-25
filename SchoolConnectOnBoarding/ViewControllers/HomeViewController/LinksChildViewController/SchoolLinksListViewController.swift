//
//  SchoolLinksListViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 3/23/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

protocol SchoolLinksListViewProtocol: class {
    
    // MARK: - Closures
    
    var onDidSelectLink: ((String) -> Void)? { get set }
    
    // MARK: - Methods
    
    func didReceiveLinks(_ data: [SCHomeLink])
}

class SchoolLinksListView: UIView, SchoolLinksListViewProtocol {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private var viewModel: SchoolLinksListViewModelProtocol!
    
    // MARK: - SchoolLinksListViewProtocol
    
    var onDidSelectLink: ((String) -> Void)?
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setMargins(top: Style.Layout.innerSpacing,
                   leading: Style.Layout.marginXL,
                   bottom: Style.Layout.marginXL,
                   trailing: Style.Layout.marginXL)
        
        backgroundColor = .white
        tableView.pinToMargins()
    }
    
    // MARK: - Methods
    
    func didReceiveLinks(_ data: [SCHomeLink]) {
        viewModel.inject(data)
    }
    
    // MARK: - Private Methods
    
    private func subscribeToViewModel() {
        viewModel.onReloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension SchoolLinksListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
