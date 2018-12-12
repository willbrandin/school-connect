//
//  ContactForm.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/18/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

struct ContactForm: Encodable {
    
    //MARK: - Properties
    var name: String?
    var email: String?
    var phoneNumber: String?
    var message: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name, email, phoneNumber, message
    }
    
    //MARK: - Init
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(name, forKey: .name)
        try values.encode(email, forKey: .email)
        try values.encode(phoneNumber, forKey: .phoneNumber)
        try values.encode(message, forKey: .message)
    }
    
    //MARK: - Methods
    func postContactForm(){
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.sendMessage(data: ["name":"William"])
        
        networkManager.post(for: endpoint, ContactForm.self) { (result) in
            switch result {
            case .success:
                print("success")
            case .error:
                print("error")
            }
        }
    }
    
}
