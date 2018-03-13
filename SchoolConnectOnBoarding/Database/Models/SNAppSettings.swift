//
//  SNAppSettings.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RealmSwift

class SNAppSettings: Object {
    
    //MARK: - Properties
    @objc dynamic var primaryColor: String?
    @objc dynamic var secondaryColor: String?
    @objc dynamic var defaultImgUrl: String?
    
    //MARK: - Init
    
    func initWithResponse(_ dataDictionary: NSDictionary){
        //Check for updated settings
        self.primaryColor = dataDictionary["primaryColor"] as? String
        self.secondaryColor = dataDictionary["secondaryColor"] as? String
        self.defaultImgUrl = dataDictionary["defaultImg"] as? String
    }
    
    //MARK: - Methods
    
}
