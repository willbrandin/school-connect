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
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar Events"
        setupCalendarView()
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
    
    
    
}


//MARK: - Delegate

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = calendarView.tableView.dequeueReusableCell(withIdentifier: CalendarTableViewCell.cellId, for: indexPath) as? CalendarTableViewCell
//        cell?.configureCell()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
