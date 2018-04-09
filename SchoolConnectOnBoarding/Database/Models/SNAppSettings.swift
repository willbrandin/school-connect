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
    var features = List<String>()
    
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        primaryColor = try values.decodeIfPresent(String.self, forKey: .primaryColor)!
        secondaryColor = try values.decodeIfPresent(String.self, forKey: .secondaryColor)!
        defaultImgUrl = try values.decodeIfPresent(String.self, forKey: .defaultImgUrl)!
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)!
    }
    
    enum CodingKeys: String, CodingKey
    {
        case primaryColor, secondaryColor, defaultImgUrl
        case schoolId = "school"
    }
    
    //MARK: - Init
    
    func initWithResponse(_ dataDictionary: NSDictionary){
        //Check for updated settings
        self.primaryColor = dataDictionary["primaryColor"] as? String
        self.secondaryColor = dataDictionary["secondaryColor"] as? String
        self.defaultImgUrl = dataDictionary["defaultImg"] as? String
        if let features = dataDictionary["features"] as? [String] {
            for feature in features {
                self.features.append(feature)
            }
        }
       
        
    }
    
    //MARK: - Methods
    
}
