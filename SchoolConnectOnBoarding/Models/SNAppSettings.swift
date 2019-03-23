//
//  SNAppSettings.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class SNAppSettings: Codable {
    
    // MARK: - Properties
    
    let primaryColor: String?
    let secondaryColor: String?
    let defaultImgUrl: String?
    let schoolId: String?
    let settingsId: String?
    var features: [String]?
    var featuresList: [String]?
    
    enum CodingKeys: String, CodingKey {
        case primaryColor, secondaryColor, defaultImgUrl, features
        case schoolId = "school"
        case settingsId = "_id"
    }
}
