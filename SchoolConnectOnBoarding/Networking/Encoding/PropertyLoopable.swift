//
//  PropertyLoopable.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

public protocol PropertyLoopable: Codable {
    func allProperties() throws -> [String: Any]
}

extension PropertyLoopable {
    
    public func allProperties() throws -> [String: Any] {
        
        var result: [String: Any] = [:]
        
        let mirror = Mirror(reflecting: self)
        
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }
        
        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            
            result[property] = value
        }
        
        return result
    }
    
}
