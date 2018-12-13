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
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        id = try values.decodeIfPresent(String.self, forKey: .id)!
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
    }
}
