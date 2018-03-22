//
//  LinkCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/20/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class LinkCell: UITableViewCell {

    //MARK: - Properties
    static var cellId = CellReuseIds.linkTableCell.rawValue
    
    //MARK: - UI Elements
    
    lazy var linkTitleLabel: UILabel! = {
        let label = UILabel()
        label.textColor = UIColor.scGrayText()
        label.font = UIFont.boldText()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    //MARK: - Inits
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(_ homeLink: SCHomeLink?){
        if let link = homeLink {
            setupTitleConstraints()
            self.linkTitleLabel.text = link.title?.uppercased()
        }
    }
    
    //MARK: - Methods

    func setupTitleConstraints(){
        addSubview(linkTitleLabel)
        linkTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30.0).isActive = true
        linkTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        linkTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
