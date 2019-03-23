//
//  ContactForm.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import RocketNetworking

public struct ContactForm: PropertyLoopable {
    
    // MARK: - Properties
    
    var name: String?
    var email: String?
    var phoneNumber: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case name, email, phoneNumber, message
    }
}
