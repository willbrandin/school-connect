//
//  SNTabBarOption.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

enum SNTabBarOption: Int, CaseIterable {
    case home = 0
    case news
    case calendar
    case contact
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .news: return "News"
        case .calendar: return "Calendar"
        case .contact: return "Contact"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .home: return SCImages.TabBarImages.homeIcon
        case .news: return SCImages.TabBarImages.newsIcon
        case .calendar: return SCImages.TabBarImages.calendarIcon
        case .contact: return SCImages.TabBarImages.contactIcon
        }
    }
}
