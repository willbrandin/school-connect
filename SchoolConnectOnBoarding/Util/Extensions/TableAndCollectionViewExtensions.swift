//
//  SCViewProtocols.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/6/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func deqeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView{
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}


extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func deqeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView{
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}
