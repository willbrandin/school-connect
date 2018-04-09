//
//  SchoolName.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase

let SCHOOL_NAMES = [
    "Rogers High School",
    "Smith High School",
    "Davis High School",
    "Rogers Middle School",
    "Smith Elementry School",
    "Williams high school"
]

class SchoolSearch: Decodable {
    
    var name: String?
    var id: String?
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        id = try values.decodeIfPresent(String.self, forKey: .id)!
    }
    
    enum CodingKeys: String, CodingKey
    {
        case name, id
    }
    
    static func fetchNames(input: String , completion: @escaping ([SchoolSearch])->Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        var schoolNames = [SchoolSearch]()
        
        let query = ref.child("Schools").queryOrdered(byChild: "name").queryStarting(atValue: input).queryEnding(atValue: input + "\u{F8FF}")
        
        query.observe(.childAdded) { (snapshot) in
        
            if let data = snapshot.value as? NSDictionary {
                var newSchool = SchoolSearch()
                newSchool.name = data["name"] as? String
                newSchool.id = snapshot.key
                schoolNames.append(newSchool)
                completion(schoolNames)
            }
        }
    }
    
}







