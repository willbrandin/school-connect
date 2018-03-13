//
//  SideButton.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class SideButtonView: UIView {
    
    override func draw(_ rect: CGRect) {
        /// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
        SNDatabaseQueryManager.getSavedPrimaryColor()?.setFill()
        ovalPath.fill()
        
        
        /// Group 2
        /// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 67.94, y: 49.93))
        bezierPath.addLine(to: CGPoint(x: 47, y: 25))
        SNDatabaseQueryManager.getSavedSecondaryColor()?.setStroke()
        bezierPath.lineWidth = 4
        bezierPath.lineCapStyle = .round
        bezierPath.stroke()
        
        
        /// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 67.94, y: 50.07))
        bezier2Path.addLine(to: CGPoint(x: 47, y: 75))
        SNDatabaseQueryManager.getSavedSecondaryColor()?.setStroke()
        bezier2Path.lineWidth = 4
        bezier2Path.lineCapStyle = .round
        bezier2Path.stroke()

    }
    
}
