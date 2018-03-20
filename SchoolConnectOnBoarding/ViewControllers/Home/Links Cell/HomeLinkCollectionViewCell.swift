//
//  HomeLinkCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class HomeLinkCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    static var reuseID = "HomeLinkCell"
    
    //MARK: - UI Elements
    
    lazy var linkTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .semibold)
        label.text = "Useful Links"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    //MARK: - Methods
    func configureCell(){
        setupTitleConstraints()
        setupTableConstraints()
        
    }
    
    func setupTableConstraints(){
        tableView = UITableView()
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.linkTitleLabel.bottomAnchor, constant: 5.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.0).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(LinkCell.self, forCellReuseIdentifier: LinkCell.cellId)
    }
    
    func setupTitleConstraints(){
        addSubview(linkTitleLabel)
        linkTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
        linkTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        linkTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        linkTitleLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
    }
    
}

extension HomeLinkCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //number of links
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.cellId, for: indexPath) as! LinkCell
        cell.accessoryType = .disclosureIndicator
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func openInBrowser(){
//        if let url = URL(string: link.linkURL) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
    }

}





