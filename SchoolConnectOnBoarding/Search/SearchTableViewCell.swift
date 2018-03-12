//
//  SearchTableViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    //MARK: - Life Cycle and Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Properties
    
    lazy var schoolLabel: UILabel! = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 26.0, weight: .bold)
        label.textColor = UIColor.cfnGreen()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Methods
    func setupLabelConstraints(){
        self.contentView.addSubview(schoolLabel)
        schoolLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
        schoolLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12.0).isActive = true
        schoolLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12.0).isActive = true
        schoolLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12.0).isActive = true
    }
    
    func configureCell(_ school: SchoolSearch){
        schoolLabel.text = school.name
    }
    

}
