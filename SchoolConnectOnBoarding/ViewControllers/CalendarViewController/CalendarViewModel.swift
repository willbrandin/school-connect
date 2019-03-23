//
//  CalendarViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 1/30/19.
//  Copyright © 2019 William Brandin. All rights reserved.
//

import UIKit

protocol CalendarViewModelProtocol: class {
    var onCalendarItemSelected:((CalendarEvent) -> Void)? { get set }
    var onReceivedData: (() -> Void)? { get set }
    var onNetworkIsLoading: ((Bool) -> Void)? { get set }
    var onErrorReceived: (() -> Bool)? { get set }
    
    var cellHeight: CGFloat { get }
    var numberOfSections: Int { get }
    
    func numberOfRows(in section: Int) -> Int
    func cellViewModel(for indexPath: IndexPath) -> String?
    func requestCalendarEvents()
    func didSelectItem(at indexPath: IndexPath)
    func calendarEvent(for indexPath: IndexPath) -> CalendarEvent?
}

final class CalendarViewModel: CalendarViewModelProtocol {
    
    var onCalendarItemSelected: ((CalendarEvent) -> Void)?
    var onReceivedData: (() -> Void)?
    var onNetworkIsLoading: ((Bool) -> Void)?
    var onErrorReceived: (() -> Bool)?
    
    private var calendarEvents: [CalendarEvent] = [] {
        didSet {
            calendarEvents.sort(by: { $0.startDate!.stringToDate().timeIntervalSinceNow > $1.startDate!.stringToDate().timeIntervalSinceNow })
            onReceivedData?()
        }
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var cellHeight: CGFloat {
        return 120
    }
    
    func requestCalendarEvents() {
        let id = UserDefaultsManager.selectedUserSchoolId ?? ""
        let endpoint = SchoolConnectAPI.calendar(id: id)
        
        requestCalendarEvents(with: endpoint)
    }
    
    func numberOfRows(in section: Int) -> Int {
        return calendarEvents.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> String? {
        return nil
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        onCalendarItemSelected?(calendarEvents[indexPath.row])
    }
    
    func calendarEvent(for indexPath: IndexPath) -> CalendarEvent? {
        return calendarEvents[indexPath.row]
    }
    
    // MARK: - Private Methods
    private func requestCalendarEvents(with endpoint: SchoolConnectAPI) {
        let networkManager = NetworkManager.sharedInstance
        
        networkManager.requestWithListResponse(for: endpoint, [CalendarEvent].self) { [weak self] result in
            switch result {
            case .success(let events):
                self?.calendarEvents = events
            case .error:
                break
            }
        }
    }
}
