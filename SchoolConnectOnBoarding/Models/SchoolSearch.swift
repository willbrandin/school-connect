//
//  SchoolName.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/11/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

struct SchoolSearch {
    var name: String?
    
    func fetchNames(_ data: [String]) -> [SchoolSearch] {
        var schoolArray = [SchoolSearch]()
        for school in data {
            let newSchool = SchoolSearch(name: school)
            schoolArray.append(newSchool)
        }
        return schoolArray
    }
}
