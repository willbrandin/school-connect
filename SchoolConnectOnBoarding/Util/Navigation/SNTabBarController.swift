//
//  SNTabBarController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
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

class SNTabBarController: UITabBarController {
    
    private var homeViewController: HomeViewControllerProtocol?
    private var newsViewController: NewsViewControllerProtocol?
    private var calendarViewController: CalendarViewControllerProtocol?
    private var contactViewController: ContactViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewControllersAndAddNavigation()
        
    }

    private func addViewControllers() -> [UIViewController] {
        guard let homeView = createHomeViewController()?.toPresent(),
            let newsView = createNewsViewController()?.toPresent(),
            let calendarView = createCalendarViewController()?.toPresent(),
            let contactView = createContactViewController()?.toPresent() else {
            return []
        }
        
        return [homeView, newsView, calendarView, contactView]
    }
    
    func mapViewControllersAndAddNavigation(){
        viewControllers = addViewControllers().enumerated().map { index, viewController in
            viewController.tabBarItem = UITabBarItem(title: SNTabBarOption.allCases[index].title,
                                         image: SNTabBarOption.allCases[index].icon,
                                         tag: index)
            return SNBaseNavigationController(rootViewController: viewController)
        }
        setColors()
    }

    private func createHomeViewController() -> HomeViewControllerProtocol? {
        let viewModel = HomeViewModel(schoolId: UserDefaultsManager.selectedUserSchoolId)
        homeViewController = HomeViewController(viewModel: viewModel)
        return homeViewController
    }
    
    private func createNewsViewController() -> NewsViewControllerProtocol? {
        newsViewController = NewsViewController()
        return newsViewController
    }
    
    private func createCalendarViewController() -> CalendarViewControllerProtocol? {
        calendarViewController = CalendarViewController()
        return calendarViewController
    }
    
    private func createContactViewController() -> ContactViewControllerProtocol? {
        contactViewController = ContactViewController()
        return contactViewController
    }
    
}

extension SNTabBarController: SchoolColorable {
    
    func setColors(){
        self.tabBar.barTintColor = schoolPrimaryColor
        tabBar.tintColor = schoolSecondaryColor
        
        if (tabBar.barTintColor?.isLight)! {
            tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            tabBar.unselectedItemTintColor = UIColor.lightGray
        }
    }

}
