//
//  SNAppSettings.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RealmSwift

class SNAppSettings: Object, Decodable {
    
    //MARK: - Properties
    @objc dynamic var primaryColor: String?
    @objc dynamic var secondaryColor: String?
    @objc dynamic var defaultImgUrl: String?
    @objc dynamic var schoolId: String?
    @objc dynamic var settingsId: String?
    var features = List<String>()
    
    //MARK: - Init
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        primaryColor = try values.decodeIfPresent(String.self, forKey: .primaryColor)!
        secondaryColor = try values.decodeIfPresent(String.self, forKey: .secondaryColor)!
        defaultImgUrl = try values.decodeIfPresent(String.self, forKey: .defaultImgUrl)!
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)!
        //features = try values.decodeIfPresent(List<String>.self, forKey: .features)!
    }
    
    enum CodingKeys: String, CodingKey
    {
        case primaryColor, secondaryColor, defaultImgUrl //, features
        
        case schoolId = "school"
        
        case settingsId = "_id"
    }
    
    override open static func primaryKey() -> String? {
        
        return "settingsId"
    }
    //MARK: - Methods
    
}
