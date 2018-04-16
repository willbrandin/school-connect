//
//  Extensions.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/10/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
    
}

extension UIAlertController {
    
    class func defaultAlert(_ title: String, _ message: String) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func addDefaultAction(){
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        self.addAction(action)
    }
}
