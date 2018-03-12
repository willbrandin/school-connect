//
//  School.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import Firebase

class School {
    
    var schoolName: String?
    var schoolId: String?
    var schoolCity: String?
    var schoolState: String?
    
    func initForSearch(_ dataDictionary: NSDictionary){
        self.schoolName = dataDictionary["schoolName"] as? String
        self.schoolCity = dataDictionary["schoolCity"] as? String
        self.schoolState = dataDictionary["schoolState"] as? String
    }
    
    static func fetchNames(input: String , completion: @escaping ([School])->Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        var schoolNames = [School]()
        
        let query = ref.child("Schools").queryOrdered(byChild: "schoolName").queryStarting(atValue: input).queryEnding(atValue: input + "\u{F8FF}")
        
        query.observe(.childAdded) { (snapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                let newSchool = School()
                newSchool.initForSearch(data)
                newSchool.schoolId = snapshot.key
                schoolNames.append(newSchool)
                completion(schoolNames)
            }
        }
    }
    
    
    
}
