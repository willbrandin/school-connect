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
    var features: [String]?
    var featuresList: List<String> = List<String>()
    
    //MARK: - Init
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        primaryColor = try values.decodeIfPresent(String.self, forKey: .primaryColor)!
        secondaryColor = try values.decodeIfPresent(String.self, forKey: .secondaryColor)!
        defaultImgUrl = try values.decodeIfPresent(String.self, forKey: .defaultImgUrl)!
        schoolId = try values.decodeIfPresent(String.self, forKey: .schoolId)!
        settingsId = try values.decodeIfPresent(String.self, forKey: .settingsId)!
        features = try values.decodeIfPresent([String].self, forKey: .features)!
        
        if let array = features {
            array.forEach { (feature) in
                featuresList.append(feature)
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case primaryColor, secondaryColor, defaultImgUrl, features
        case schoolId = "school"
        case settingsId = "_id"
    }
    
    override open static func primaryKey() -> String? {
        return "schoolId"
    }
    //MARK: - Methods
    
    static func fetchAppConfigSettings(with schoolId: String?, update: Bool = true, completion: @escaping (Bool)->Void = {_ in } ) {
        guard let id = schoolId else {
            completion(false)
            return
        }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.configSettings(id: id)
        
        networkManager.get(for: endpoint, SNAppSettings.self, completion: {result in
            switch result {
            case .success(let settings):
                let returnedSettings = settings as! SNAppSettings
                
                returnedSettings.saveConfigSettings(update: update, completion: completion)
            case .error:
                completion(false)
            }
        })
    }
    
    private func saveConfigSettings(update: Bool, completion: @escaping (Bool) -> Void){
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
