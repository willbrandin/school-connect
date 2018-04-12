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

class CalendarCellSideButtonView: UIView, SchoolColorable {
    
    override func draw(_ rect: CGRect) {
        /// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        schoolSecondaryColor?.setFill()
        ovalPath.fill()
        
        
        /// Group 2
        /// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 47.adjustForSize(size: self.bounds.width), y: 29.adjustForSize(size: self.bounds.height)))
        bezierPath.addLine(to: CGPoint(x: 65.adjustForSize(size: self.bounds.width), y: 50.adjustForSize(size: self.bounds.height)))
        bezierPath.addLine(to: CGPoint(x: 47.adjustForSize(size: self.bounds.width), y: 71.adjustForSize(size: self.bounds.height)))
        schoolPrimaryColor?.setStroke()
        bezierPath.lineWidth = 4
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()
        
    }
    
}


extension Int {
    
    fileprivate func adjustForSize(size: CGFloat) -> Int {
        return self * Int(size) / 100
    }
}
