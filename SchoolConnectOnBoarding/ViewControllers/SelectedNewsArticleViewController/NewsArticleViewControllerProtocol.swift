//
//  NewsArticleViewControllerProtocol.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import Foundation

protocol NewsArticleViewControllerProtocol: Presentable {
    var onTapToClose: (() -> Void)? { get set }
}
