//
//  SCEnums.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit


enum UserDefaultKeys: String {
    case schoolChosen = "schoolIsChosen"
    case selectedId = "selectedSchoolId"
}

@available(*, deprecated)
enum FirebasePathStrings: String {
    case schoolInfo = "SchoolInfo"
    case schools = "Schools"
    case appConfig = "appConfig"
    case infoPath = "Info"
    case newsPath = "News"
    case calendarPath = "Calendar"
    case homeLinks = "Links"
}

@available(*, deprecated)
enum FirebaseSchoolInfoPath: String {
    case appConfig = "appConfig"
    case infoPath = "Info"
}

enum WBDateFormat: String {
    case simpleDate = "MM/dd/yyyy"
    case dateAndTime = "MMMM d, h:mm a"
    case weekDayAndTime = "EEEE, MMMM d, h:mm a"
    case serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}

///TextField and TextView validation types.
///Could be expanded to have other inputs like dates.
///Raw value is used for the title of the text field/text view Title
enum WBTextValidationType: String {
    case name = "Name"
    case email = "Email"
    case phoneNumber = "Phone Number"
    case message = "Message"
}










