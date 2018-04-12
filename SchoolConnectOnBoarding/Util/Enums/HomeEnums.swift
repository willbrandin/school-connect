//
//  HomeEnums.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit

enum HomeCellIndex: Int {
    case greeting = 0
    case featureCell = 1
    case linksCell = 2
    
}

enum HomeFeature: String {
    
    case bullyReporting = "bully-report"
    case teacherContact = "teacher-contact"
    case mapOfSchool = "map-of-school"
    
    enum FeatureCellText: String {
        case bullyReportTitle = "Bully Reporting"
        case bullyReportSubtitle = "Report instances of bullying directly to your principal."
        
        case teacherContactTitle = "Contact your Teacher"
        case teacherContactSubtitle = "Reach your teacher from your mobile device."
        
        case mapOfSchoolTitle = "School Map"
        case mapOfSchoolSubtitle = "Get an arial view of the school!"
        
    }
    
    
    func setFeatureView() -> UIViewController {
        let vc = UIViewController()
        
        switch self {
        case .bullyReporting:
            //return specific view controller
            vc.title = PageTitles.bullyReporting.rawValue
        case .teacherContact:
            vc.title = PageTitles.teacherContact.rawValue
        case .mapOfSchool:
            vc.title = PageTitles.mapOfSchool.rawValue
            
        }
        return vc
    }
    
    func customizeUI(_ view: FeatureCardView) {
        switch self {
        case .bullyReporting:
            view.configureCardView(FeatureCellText.bullyReportTitle.rawValue,
                                   FeatureCellText.bullyReportSubtitle.rawValue,
                                   UIImage(named: "classroom"))
        case .teacherContact:
            view.configureCardView(FeatureCellText.teacherContactTitle.rawValue,
                                   FeatureCellText.teacherContactSubtitle.rawValue,
                                   UIImage(named: "landingPageIcon"))
        case .mapOfSchool:
            view.configureCardView(FeatureCellText.mapOfSchoolTitle.rawValue,
                                   FeatureCellText.mapOfSchoolSubtitle.rawValue,
                                   UIImage(named: "student-walk"))
            
        }
    }
    
    
}
