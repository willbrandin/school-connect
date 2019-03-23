//
//  CalendarEventViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit
import EventKit

protocol CalendarEventViewControllerProtocol: Presentable {
}

class CalendarEventViewController: SNBaseViewController, CalendarEventViewControllerProtocol {
    
    //MARK: - Properties
    var eventView: CalendarEventView!
    private let selectedEvent: CalendarEvent?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEventView()
        setTitle()
    }

    init(selectedEvent: CalendarEvent) {
        self.selectedEvent = selectedEvent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupEventView(){
        eventView = CalendarEventView()
        eventView.onDidTapAddToCalendar = { [weak self] in
            self?.saveToCalendar()
        }
        
        eventView.customizeUI(selectedEvent)
        view.addSubview(eventView)
        eventView.pinToSuperview()
    }
    
    private func setTitle(){
        if let event = selectedEvent {
            title = event.title
        }
    }
    
    // TODO: - ViewModel
    private func saveToCalendar() {
        addEventToCalendar(with: selectedEvent!) { (success, err) in
            if success {
                print("Added to Calendar")
            } else {
                print("Error")
            }
        }
    }
  
    ///Adds the ability to add event to the user calendar as an event.
    private func addEventToCalendar(with newEvent: CalendarEvent, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                
                let event = EKEvent(eventStore: eventStore)
                event.title = newEvent.title
                event.startDate = newEvent.startDate?.stringToDate()
                if let newEventEndDate = newEvent.endDate?.stringToDate() {
                    event.endDate = newEventEndDate
                } else {
                    let calendar = Calendar.current
                    let endDate = newEvent.startDate?.stringToDate()
                    let date = calendar.date(byAdding: .minute, value: 120, to: endDate!)
                    event.endDate = date
                }
                event.notes = newEvent.description
                event.location = newEvent.location
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let err as NSError {
                    completion?(false, err)
                    return
                }
                completion?(true, nil)
                
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
    
}
