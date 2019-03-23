//
//  SCUIKit.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SCCircleImage: UIImageView, CornerRoundable {
    override func layoutSubviews() {
        roundCorners()
    }
}
