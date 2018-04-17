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

class School: RealmSwift.Object, Decodable {
    
    //MARK: - Properties
    @objc dynamic var schoolName: String?
    @objc dynamic var schoolId: String?
    @objc dynamic var schoolCity: String?
    @objc dynamic var schoolState: String?
    
    
    //MARK: - Init
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        schoolName = try values.decodeIfPresent(String.self, forKey: .schoolName)
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)
        schoolCity = try values.decodeIfPresent(String.self, forKey: .schoolCity)
        schoolState = try values.decodeIfPresent(String.self, forKey: .schoolState)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case schoolCity = "city"
        case schoolState = "state"
        case schoolName = "name"
        case schoolId = "school"
    }
    
    override open static func primaryKey() -> String? {
        //TODO: Replace with enum raw value.
        return "schoolId"
    }

    
    //MARK: - Methods

    static func fetchDetails(with schoolId: String?, completion: @escaping (Result<School, Error>)->Void) {
        guard let id = schoolId else {
            completion(Result.error(SCErrors.noSchoolId))
            return
        }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.schoolDetails(id: id)
        
        networkManager.get(for: endpoint, School.self, completion: {result in
            switch result {
            case .success(let school):
                let returnedSchool = school as! School
                completion(Result.success(returnedSchool))
            case .error(let error):
                completion(Result.error(error))
            }
        })
        
    }
    
    func saveSchoolDetails(update: Bool, completion: @escaping (Bool) -> Void = {_ in } ){
        DispatchQueue.main.async {
            autoreleasepool {
                if update {
                    DatabaseManager.save(self)
                    completion(true)
                } else {
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(self)
                        completion(true)
                    }
                }
            }
        }
    }
    
    
    //******Deprecated******//
    ///Fetches list of schools for onboarding.
    @available(*, deprecated)
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
                if let _ = snapshot.value as? NSDictionary {
                    //newStoredSchool.initSchoolDetails(infoData)
                }
            }
            if snapshot.key == FirebaseSchoolInfoPath.appConfig.rawValue {
                if let _ = snapshot.value as? NSDictionary {
                    //newStoredSchool.initAppSettings(appSettingsData)
                    
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
