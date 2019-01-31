//
//  CalendarViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol CalendarViewControllerProtocol: Presentable {
    var didSelectItem: ((CalendarEvent) -> Void)? { get set }
}

class CalendarViewController: SNBaseViewController, CalendarViewControllerProtocol {

    //MARK: - Properties
    var calendarView: CalendarView!
    
    // MARK: - CalendarViewControllerProtocol
    var didSelectItem: ((CalendarEvent) -> Void)?
    private var viewModel: CalendarViewModelProtocol = CalendarViewModel()

    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = PageTitles.calendar.rawValue
        
        setupCalendarView()
        setDelegates()
        subscribeToViewModel()
    }

    //MARK: - Private Methods
    private func setupCalendarView(){
        calendarView = CalendarView()
        calendarView.customizeUI()
        self.view.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        calendarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setDelegates() {
        calendarView.tableView.delegate = self
        calendarView.tableView.dataSource = self
        calendarView.tableView.register(CalendarTableViewCell.self)
    }
    
    private func subscribeToViewModel() {
        viewModel.onReceivedData = { [weak self] in
            DispatchQueue.main.async {
                self?.calendarView.tableView.reloadData()
            }
        }
        viewModel.onCalendarItemSelected = didSelectItem
        viewModel.requestCalendarEvents()
    }
}

//MARK: - Delegate

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: CalendarTableViewCell = tableView.deqeueReusableCell(for: indexPath)
        
        cell.configureCell(viewModel.calendarEvent(for: indexPath))
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
        viewModel.didSelectItem(at: indexPath)
//        let selectedEvent = calendarArray[indexPath.row]
//        let selectedEventVC = SelectedCalendarEventViewController(selectedEvent: selectedEvent)
//        show(selectedEventVC, sender: nil)
    }
}
