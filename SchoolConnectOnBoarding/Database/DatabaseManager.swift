//
//  DatabaseManager.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RealmSwift

let SNDatabase = try! Realm()

final class DatabaseManager {
    
    ///Saves object and updates
    class func save(_ thisObject:Object){
        
        try! SNDatabase.write {
            SNDatabase.add((thisObject), update: true)
        }
    }
    
    class func saveRealmArray(_ objects: [Object], update: Bool) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(objects, update: update)
        }
    }
}


final class SCDatabaseQueryManager {
    
    //MARK: - Primary School Info
    class func savedSchool() -> School? {
        let defaults = UserDefaults.standard
        guard let id = defaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return nil }
        let schoolQuery = SNDatabase.object(ofType: School.self, forPrimaryKey: id)
        
        return schoolQuery
    }
    
    class func getSavedPrimaryColor() -> UIColor? {
        let defaults = UserDefaults.standard
        guard let id = defaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return nil }
        let schoolQuery = SNDatabase.object(ofType: School.self, forPrimaryKey: id)
        guard let primaryColor = schoolQuery?.appSettings?.primaryColor else { return nil }
        
        return UIColor(hex: primaryColor)
    }
    
    class func getSavedSecondaryColor() -> UIColor? {
        let defaults = UserDefaults.standard
        guard let id = defaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return nil }
        let schoolQuery = SNDatabase.object(ofType: School.self, forPrimaryKey: id)
        guard let secondaryColor = schoolQuery?.appSettings?.secondaryColor else { return nil }
        
        return UIColor(hex: secondaryColor)
    }
    
    class func getSavedLinks() -> [SCHomeLink] {
        let linksQuery = SNDatabase.objects(SCHomeLink.self)
        return Array(linksQuery)
    }
    
    class func getSavedListOfFeatures() -> [String?] {
        if let featureQuery = savedSchool()?.appSettings?.features {
            return Array(featureQuery)
        }
        return [nil]
    }
    
    
}
















