//
//  SchoolLinksListViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 3/23/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

protocol SchoolLinksListViewModelProtocol: class {
    // MARK: - Closures
    
    var onReloadData: (() -> Void)? { get set }
    
    // MARK: - Methods
    
    func inject(_ data: [SCHomeLink])
}

class SchoolLinksListViewModel: SchoolLinksListViewModelProtocol {
    
    // MARK: - SchoolLinksListViewModelProtocol
    
    var onReloadData: (() -> Void)?
    
    // MARK: - Methods
    
    func inject(_ data: [SCHomeLink]) {
    }
}
