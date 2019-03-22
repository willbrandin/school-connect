//
//  SNBaseNavigationController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

//class SNBaseNavigationController: UINavigationController, SchoolColorable {
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if (navigationBar.barTintColor?.isLight)! {
//            return .default
//        }
//        return .lightContent
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupNavigationAttributes()
//    }
//
//    //MARK: - Methods
//
//    func setupNavigationAttributes() {
//        navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
//        navigationBar.barTintColor = schoolPrimaryColor
//
//        if (navigationBar.barTintColor?.isLight)! {
//            let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
//            navigationBar.titleTextAttributes = textAttributes
//            navigationBar.largeTitleTextAttributes = textAttributes
//        } else {
//            let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//            navigationBar.titleTextAttributes = textAttributes
//            navigationBar.largeTitleTextAttributes = textAttributes
//        }
//
////        navigationBar.tintColor = schoolSecondaryColor
//    }
//
//}
