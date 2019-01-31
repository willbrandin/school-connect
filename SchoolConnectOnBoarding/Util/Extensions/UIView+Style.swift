//
//  UIView+Style.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/26/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

/// A struct that wraps shadow styles.
public struct LayerShadow: Equatable {
    public let shadowColor: UIColor
    public let shadowOpacity: Float
    public let shadowRadius: CGFloat
    public let shadowOffset: CGSize
    
    public init(shadowColor: UIColor,
                shadowOpacity: Float,
                shadowRadius: CGFloat,
                shadowOffset: CGSize) {
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
    }
}

public extension UIView {
    /// Sets a LayerShadow on a UIView
    public func setShadow(shadow: LayerShadow) {
        layer.shadowColor = shadow.shadowColor.cgColor
        layer.shadowOffset = shadow.shadowOffset
        layer.shadowRadius = shadow.shadowRadius
        layer.shadowOpacity = shadow.shadowOpacity
    }
}
