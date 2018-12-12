//
//  SCErrors.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import Foundation
import UIKit

enum SCErrors: Error {
    case noSchoolLinks
    case noSchoolId
    case noFetchedNews
    case noFetchedEvents
    
    case confirmationError
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
        case .noFetchedNews:
            let alert = UIAlertController.defaultAlert("No News!", "Something isn't right. Try again later.")
            alert.addDefaultAction()
            return alert
        case .noFetchedEvents:
            let alert = UIAlertController.defaultAlert("No Events!", "Something isn't right. Try again later.")
            alert.addDefaultAction()
            return alert
        default:
            let alert = UIAlertController.defaultAlert("Hmm", "Something isn't right. Try again later.")
            alert.addDefaultAction()
            return alert
        }
    }
}
