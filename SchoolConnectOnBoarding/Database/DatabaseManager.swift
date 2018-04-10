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
        
        try! SNDatabase.write {
            SNDatabase.add(objects, update: update)
        }
    }
    
    ///Removes School Object in Realm. Takes Feature data as well
    class func removeSchools(){
        let realm = try! Realm()
        try! realm.write {
            let results = realm.objects(School.self)
            realm.delete(results)
        }
    }
    class func cancelTransaction(){
        SNDatabase.cancelWrite()
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
        let primaryColor = "000000"
            //schoolQuery?.appSettings?.primaryColor else { return nil }
        
        return UIColor(hex: primaryColor)
    }
    
    class func getSavedSecondaryColor() -> UIColor? {
        let defaults = UserDefaults.standard
        guard let id = defaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return nil }
        let schoolQuery = SNDatabase.object(ofType: School.self, forPrimaryKey: id)
        let primaryColor = "000000"
        //guard let secondaryColor = schoolQuery?.appSettings?.secondaryColor else { return nil }
        
        return UIColor(hex: primaryColor)
    }
    
    class func getSavedLinks() -> [SCHomeLink] {
        let linksQuery = SNDatabase.objects(SCHomeLink.self)
        return Array(linksQuery)
    }
    
    class func getSavedListOfFeatures() -> [String?] {
//        if let featureQuery = savedSchool()?.appSettings?.features {
//            return Array(featureQuery)
//        }
        return [nil]
    }
    
    
    
}

