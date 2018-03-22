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
    static var reuseID = CellReuseIds.homeLinkCollectionCell.rawValue
    var linksArray = [SCHomeLink]()
    
    //MARK: - UI Elements
    
    lazy var linkTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.heroTitle()
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
        self.clipsToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    //MARK: - Methods
    func configureCell(){
        setupTitleConstraints()
        setupTableConstraints()
        setLinksArrayWithDBData()
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

//MARK: - Networking
extension HomeLinkCollectionViewCell {
    
    //get from database and put in array
    func setLinksArrayWithDBData(){
        //SCDataQueManager get links
        let savedLinks = SCDatabaseQueryManager.getSavedLinks()
        linksArray = savedLinks
    }
    
}



extension HomeLinkCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.cellId, for: indexPath) as! LinkCell
        cell.accessoryType = .disclosureIndicator
        cell.configureCell(linksArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openInBrowser(linksArray[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func openInBrowser(_ link: SCHomeLink){
        guard let linkURL = link.linkUrl else { return }
        if let url = URL(string: linkURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}





