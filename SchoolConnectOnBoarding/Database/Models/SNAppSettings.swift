//
//  SNAppSettings.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class SNAppSettings: Codable {
    
    //MARK: - Properties
    let primaryColor: String?
    let secondaryColor: String?
    let defaultImgUrl: String?
    let schoolId: String?
    let settingsId: String?
    var features: [String]?
    var featuresList: [String]?
    
    //MARK: - Init
    
    enum CodingKeys: String, CodingKey {
        case primaryColor, secondaryColor, defaultImgUrl, features
        case schoolId = "school"
        case settingsId = "_id"
    }
    
    //MARK: - Methods
    
    static func fetchAppConfigSettings(with schoolId: String?, update: Bool = true, completion: @escaping (Bool)->Void = {_ in } ) {
        guard let id = schoolId else {
            completion(false)
            return
        }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.configSettings(id: id)
        
        networkManager.request(for: endpoint, SNAppSettings.self, completion: {result in
            switch result {
            case .success(let settings):
                let returnedSettings = settings as! SNAppSettings
                
//                returnedSettings.saveConfigSettings(update: update, completion: completion)
            case .error:
                completion(false)
            }
        })
    }
    
}
