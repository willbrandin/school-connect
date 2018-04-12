//
//  SCHomeCollectionViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCHomeCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        makeShadow()
    }
    
    func makeShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 10.0
    }
}
