//
//  CalendarEvent.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class CalendarEvent: Codable {
    
    //MARK: Properties
    var title: String?
    var startDate: String?
    var endDate: String? = "2018-04-22T13:20:55.302Z"
    var description: String?
    var location: String?
    var schoolId: String?
    
    enum CodingKeys: String, CodingKey {
        case title, startDate, description, location
        case schoolId = "school"
    }
}
