//
//  CalendarViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol CalendarViewControllerProtocol: Presentable {
    var didSelectItem: (() -> Void)? { get set }
}

class CalendarViewController: SNBaseViewController, CalendarViewControllerProtocol {

    //MARK: - Properties
    var calendarView: CalendarView!
    var calendarArray = [CalendarEvent]()
    
    // MARK: - CalendarViewControllerProtocol
    var didSelectItem: (() -> Void)?
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = PageTitles.calendar.rawValue
        
        
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
        calendarView.tableView.register(CalendarTableViewCell.self)
        
    }
    
}

//MARK: - Network Call
extension CalendarViewController {
    func fetchCalendarEvents(){
        let id = UserDefaultsManager.selectedUserSchoolId ?? ""
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.calendar(id: id)
        
        networkManager.requestWithListResponse(for: endpoint, [CalendarEvent].self) { [weak self] result in
            switch result {
            case .success(let events):
                self?.calendarArray = events
                self?.calendarArray.sort(by: { $0.startDate!.stringToDate().timeIntervalSinceNow > $1.startDate!.stringToDate().timeIntervalSinceNow })
                DispatchQueue.main.async { [weak self] in
                    self?.calendarView.tableView.reloadData()
                }
            case .error:
                break
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

        let cell: CalendarTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        
        cell.configureCell(calendarArray[indexPath.row])
        cell.selectionStyle = .none

        return cell
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
        let selectedEventVC = SelectedCalendarEventViewController(selectedEvent: selectedEvent)
        show(selectedEventVC, sender: nil)
    }
}
