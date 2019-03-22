//
//  CalendarCoordinator.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/31/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

final class CalendarCoordinator: NavigationFlowCoordinator, TabCoordinatable {
    
    private var calendarViewController: CalendarViewControllerProtocol?
    private var calendarEventViewController: CalendarEventViewControllerProtocol?
    
    var tabNavigationController: UIViewController? {
        return mainViewController?.navigationController
    }
    
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: SNTabBarOption.calendar.title,
                            image: SNTabBarOption.calendar.icon,
                            tag: 2)
    }
    
    override func createMainViewController() -> UIViewController? {
        print(navigationController)
        return createCalendarViewController()
    }
    
    private func createCalendarViewController() -> UIViewController? {
        calendarViewController = CalendarViewController()
        calendarViewController?.onDidSelectEvent = { [weak self] calendarEvent in
            self?.showCalendarEventViewController(with: calendarEvent)
        }
        guard let controller = calendarViewController?.toPresent() else { return nil }
        controller.tabBarItem = tabBarItem
        return controller
    }
    
    private func showCalendarEventViewController(with event: CalendarEvent?) {
        guard let event = event else { return }
        calendarEventViewController = CalendarEventViewController(selectedEvent: event)
        guard let controller = calendarEventViewController?.toPresent() else { return }
        push(viewController: controller)
    }
    
}
