//
//  UIEnums.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit

enum PageTitles: String {
    case home = "Home"
    case news = "News"
    case confirmation = "Confirm"
    case schoolSearch = "School Search"
    case contact = "Contact"
    case calendar = "Calendar"
    case bullyReporting = "Report Bullying"
    case teacherContact = "Reach a Teacher"
    case mapOfSchool = "School Map"
    case contactSubtitle = "How may we help you?"
}

enum CellReuseIds: String {
    case calendarCell = "CalendarCell"
    case newsArticleCardCell = "NewsArticleCell"
    case homeGreetingCollectionCell = "HomeGreetingCell"
    case featureCollectionCell = "FeatureCell"
    case homeFeatureCollectionCell = "HomeFeatureCell"
    case homeLinkCollectionCell = "HomeLinkCell"
    case linkTableCell = "LinkTableCell"
    case searchSchoolNameTableCell = "SchoolNameCell"
}
