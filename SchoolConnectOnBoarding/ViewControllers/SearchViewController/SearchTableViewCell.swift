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
    
    // MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.heightAnchor.constraint(equalToConstant: Style.Layout.cellHeight).isActive = true
        contentView.setMargins(top: Style.Layout.innerSpacing,
                               leading: Style.Layout.innerSpacing,
                               bottom: Style.Layout.innerSpacing,
                               trailing: Style.Layout.innerSpacing)
        
        setupLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    
    func setupLabelConstraints(){
        contentView.addSubview(schoolLabel)
        schoolLabel.pinToMargins()
    }
    
    func configureCell(_ school: String?){
        schoolLabel.text = school
    }
}
