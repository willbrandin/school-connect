//
//  SCHomeLink.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/20/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class SCHomeLink: Codable {
    
    //MARK: - Properties
    let title: String?
    let linkUrl: String?
    let linkId: String?
    let schoolId: String?
        
    enum CodingKeys: String, CodingKey {
        case title, linkUrl
        case linkId = "_id"
        case schoolId = "school"
    }

}
