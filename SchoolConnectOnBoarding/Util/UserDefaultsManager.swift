//
//  UserDefaultsManager.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - User Default Keys
    
    private static let selectedUserSchoolIdKey = "selectedUserSchoolIdKey"
    private static let userSelectedSchoolKey = "userSelectedSchool"
    private static let userSelectedSchoolConfigurationKey = "userSelectedSchoolConfigurationKey"
    
    // MARK: - User Default Values
    
    static var selectedUserSchoolId: String? {
        get {
            guard let value = UserDefaults.standard.string(forKey: selectedUserSchoolIdKey) else {
                return nil
            }
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: selectedUserSchoolIdKey)
        }
    }
    
    // School Config Settings
    
    static var userSelectedSchoolConfiguration: SNAppSettings? {
        get {
            return retieveEncoded(type: SNAppSettings.self, for: userSelectedSchoolConfigurationKey)
        }
        set {
            saveCodable(with: newValue, for: userSelectedSchoolConfigurationKey)
        }
    }
    
    // Selected School
    
    static var userSelectedSchool: School? {
        get {
            return retieveEncoded(type: School.self, for: userSelectedSchoolKey)
        }
        set {
            saveCodable(with: newValue, for: userSelectedSchoolKey)
        }
    }
    
    private static func saveCodable<T: Codable>(with object: T?, for key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    private static func retieveEncoded<T: Codable>(type: T.Type, for key: String) -> T? {
        if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(type, from: savedData) {
                return decodedData
            }
            return nil
        }
        return nil
    }
}
