//
//  School.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class School: Object {
    
    //MARK: - Properties
    @objc dynamic var schoolName: String?
    @objc dynamic var schoolId: String?
    @objc dynamic var schoolCity: String?
    @objc dynamic var schoolState: String?
    @objc dynamic var appSettings: SNAppSettings?
    
    
    //MARK: - Init
    func initSchoolDetails(_ dataDictionary: NSDictionary){
        self.schoolName = dataDictionary["schoolName"] as? String
        self.schoolCity = dataDictionary["schoolCity"] as? String
        self.schoolState = dataDictionary["schoolState"] as? String
    }
    
    func initAppSettings(_ data: NSDictionary){
        let newSettings = SNAppSettings()
        newSettings.initWithResponse(data)
        appSettings = newSettings
    }
    
    
    //MARK: - Methods
    
    override open static func primaryKey() -> String? {
        
        return "schoolId"
    }
    
    ///Fetches list of schools for onboarding.
    static func fetchNames(input: String , completion: @escaping ([School])->Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        var schoolNames = [School]()
        
        let query = ref.child("Schools").queryOrdered(byChild: "schoolName").queryStarting(atValue: input).queryEnding(atValue: input + "\u{F8FF}")
        
        query.observe(.childAdded) { (snapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                let newSchool = School()
                newSchool.initSchoolDetails(data)
                newSchool.schoolId = snapshot.key
                schoolNames.append(newSchool)
                completion(schoolNames)
            }
        }
    }
    
    static func getSchoolDetailsWithId(update: Bool = false, completion: @escaping (Bool)-> Void = {_ in } ) {
        //get school with id.
        let ref: DatabaseReference!
        ref = Database.database().reference()
        
        let defaults = UserDefaults.standard
        guard let id = defaults.string(forKey: UserDefaultKeys.selectedId.rawValue) else { return }
        
        let newStoredSchool = School()
        newStoredSchool.schoolId = id
        
        let queryPath = ref.child(FirebasePathStrings.schoolInfo.rawValue).child(id)
        queryPath.observe(.childAdded) { (snapshot) in
            if snapshot.key == FirebaseSchoolInfoPath.infoPath.rawValue {
                //Init info
                if let infoData = snapshot.value as? NSDictionary {
                    newStoredSchool.initSchoolDetails(infoData)
                }
            }
            if snapshot.key == FirebaseSchoolInfoPath.appConfig.rawValue {
                if let appSettingsData = snapshot.value as? NSDictionary {
                    newStoredSchool.initAppSettings(appSettingsData)
                    
                    DispatchQueue.main.async {
                        autoreleasepool {
                            if update {
                                DatabaseManager.save(newStoredSchool)
                                completion(true)
                            } else {
                                let realm = try! Realm()
                                try! realm.write {
                                    realm.add(newStoredSchool)
                                    completion(true)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}
