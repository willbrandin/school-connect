//
//  UIViewController+AddRemoveChile.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 3/23/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
