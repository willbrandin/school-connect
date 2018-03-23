//
//  SelectedCalendarEventViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit
import EventKit

protocol SaveToCalendarEventDelegate: class {
    func didTapSaveToCalendar()
}

class SelectedCalendarEventViewController: SNBaseViewController {
    
    //MARK: - Properties
    var eventView: SelectedCalendarEventView!
    var selectedEvent: CalendarEvent?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEventView()
        setTitle()
    }

    //MARK: - Methods
    func setupEventView(){
        eventView = SelectedCalendarEventView()
        eventView.saveToCalendarDelegate = self
        eventView.customizeUI(selectedEvent)
        self.view.addSubview(eventView)
        
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        eventView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        eventView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        eventView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setTitle(){
        if let event = selectedEvent {
            self.title = event.title
        }
    }
    
}

//MARK: - Delegate

extension SelectedCalendarEventViewController: SaveToCalendarEventDelegate {
    
    func didTapSaveToCalendar() {
        //Loading for set amount time
        
//        var popup = UIView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
//
//        let lb = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
//        lb.text="anything"
//        popup.backgroundColor = UIColor.red
//
//        // show on screen
//        self.view.addSubview(popup)
//        popup.addSubview(lb)
//        lb.center = popup.center
//
        addEventToCalendar { (success, err) in
            if success {
                //Loading to a check mark
                print("Added to Calendar")
            } else {
                //error
                //Loading and fail
                print("Error")

            }
        }
    }
    
    
    
    
    ///Adds the ability to add event to the user calendar as an event.
    func addEventToCalendar(completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        
        
        if let newEvent = selectedEvent {
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
    
}



