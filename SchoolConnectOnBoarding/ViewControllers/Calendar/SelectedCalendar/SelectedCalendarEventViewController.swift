//
//  SelectedCalendarEventViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

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
