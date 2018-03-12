//
//  SchoolName.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

let SCHOOL_NAMES = [
    "Rogers High School",
    "Smith High School",
    "Davis High School",
    "Rogers Middle School",
    "Smith Elementry School",
    "Williams high school"
]

struct SchoolSearch {
    var name: String?
  
    static func fetchNames(input: String , completion: @escaping ([SchoolSearch])->Void) {
        var schoolNames = [SchoolSearch]()
        let filtered = SCHOOL_NAMES.filter({$0.contains(input)})
        for name in filtered {
            let newSchool = SchoolSearch(name: name)
            schoolNames.append(newSchool)
            completion(schoolNames)
        }
    }
}
