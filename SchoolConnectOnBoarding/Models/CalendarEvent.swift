//
//  CalendarEvent.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation

class CalendarEvent: Codable {
    
    // MARK: Properties
    
    var title: String?
    var startDate: String?
    var endDate: String?
    var description: String?
    var location: String?
    var schoolId: String?
    
    enum CodingKeys: String, CodingKey {
        case title, startDate, description, location
        case schoolId = "school"
    }
}
