//
//  CalendarViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class CalendarViewController: SNBaseViewController {

    //MARK: - Properties
    var calendarView: CalendarView!
    var calendarArray = [CalendarEvent]()
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Calendar"
        
        
        setupCalendarView()
        fetchCalendarEvents()
        
        setDelegates()
        // Do any additional setup after loading the view.
    }

    
    //MARK: - Methods
    func setupCalendarView(){
        calendarView = CalendarView()
        calendarView.customizeUI()
        self.view.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        calendarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setDelegates() {
        calendarView.tableView.delegate = self
        calendarView.tableView.dataSource = self
        calendarView.tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: CalendarTableViewCell.cellId)
        
    }
    
}

//MARK: - Network Call
extension CalendarViewController {
    
    func fetchCalendarEvents(){
        CalendarEvent.downloadEventData { (calendars) in
            self.calendarArray = calendars
            //Sorts based on most recent  date
            self.calendarArray.sort(by: { $0.startDate!.stringToDate().timeIntervalSinceNow > $1.startDate!.stringToDate().timeIntervalSinceNow })
            DispatchQueue.main.async {
                self.calendarView.tableView.reloadData()
            }
        }
    }
}


//MARK: - Delegate

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendarArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = calendarView.tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.cellId, for: indexPath) as? CalendarTableViewCell
        cell?.configureCell(calendarArray[indexPath.row])
        cell?.selectionStyle = .none

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = tableView.cellForRow(at: indexPath) as? CalendarTableViewCell {
                cell.transform = .init(scaleX: 0.97, y: 0.97)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            if let cell = tableView.cellForRow(at: indexPath) as? CalendarTableViewCell {
                cell.transform = .identity
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = calendarArray[indexPath.row]
        let selectedEventVC = SelectedCalendarEventViewController()
        selectedEventVC.selectedEvent = selectedEvent
        show(selectedEventVC, sender: nil)
    }
    
}








