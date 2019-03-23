//
//  School.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class School: Codable {
    
    // MARK: - Properties
    
    let schoolName: String?
    let schoolId: String?
    let schoolCity: String?
    let schoolState: String?
    
    enum CodingKeys: String, CodingKey {
        case schoolCity = "city"
        case schoolState = "state"
        case schoolName = "name"
        case schoolId = "school"
    }
}
