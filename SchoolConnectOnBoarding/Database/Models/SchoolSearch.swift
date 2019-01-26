//
//  SchoolName.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class SchoolSearch: Codable {
    
    //MARK: - Properties
    var name: String?
    var id: String?
    
    //MARK: - Init
    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
    }
}
