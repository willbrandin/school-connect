//
//  UIEnums.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit

enum HomeState {
    case premium
    case linksOnly
    case featuresOnly
    case basic
}


enum WBPopUp: String {
    
    case confirmationError = "Cannot Confirm"
    case fetchError
    
    func initAlert() -> UIAlertController {
        
        switch self {
        case .confirmationError:
            let alert = UIAlertController.defaultAlert("Error", "Sorry! Something isn't right! Check with your school or try again later.")
            alert.addDefaultAction()
            return alert
        case .fetchError:
            let alert = UIAlertController.defaultAlert("Hmm", "Something isn't right. Try again later.")
            alert.addDefaultAction()
            return alert
        }
        
    }
}

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
