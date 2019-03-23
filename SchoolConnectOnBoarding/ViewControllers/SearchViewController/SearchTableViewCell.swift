//
//  SearchTableViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell, CellLoadableView {

    // MARK: - Properties
    
    lazy var schoolLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.boldText
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle and Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    func setupLabelConstraints(){
        contentView.addSubview(schoolLabel)
        schoolLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
        schoolLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12.0).isActive = true
        schoolLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15.0).isActive = true
        schoolLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12.0).isActive = true
    }
    
    func configureCell(_ school: String?){
        schoolLabel.text = school
    }
}
