//
//  School.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RealmSwift

class School: RealmSwift.Object, Codable {
    
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
    
    enum CodingKeys: String, CodingKey {
        case schoolCity = "city"
        case schoolState = "state"
        case schoolName = "name"
        case schoolId = "school"
    }
    
    override public static func primaryKey() -> String? {
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
        
        networkManager.request(for: endpoint, School.self, completion: {result in
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
}
