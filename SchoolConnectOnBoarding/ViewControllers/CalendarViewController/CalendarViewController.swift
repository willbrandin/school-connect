//
//  CalendarViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol CalendarViewControllerProtocol: Presentable {
    var onDidSelectEvent: ((CalendarEvent) -> Void)? { get set }
}

class CalendarViewController: SNBaseViewController, CalendarViewControllerProtocol {

    // MARK: - Properties
    
    private var calendarView: CalendarView!
    private var viewModel: CalendarViewModelProtocol = CalendarViewModel()

    // MARK: - CalendarViewControllerProtocol
    
    var onDidSelectEvent: ((CalendarEvent) -> Void)?
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = PageTitles.calendar.rawValue
        
        setupCalendarView()
        setDelegates()
        subscribeToViewModel()
    }

    // MARK: - Private Methods
    
    private func setupCalendarView(){
        calendarView = CalendarView()
        view.addSubview(calendarView)
        
        calendarView.onRefresh = { [weak self] in
            self?.viewModel.requestCalendarEvents()
            self?.calendarView.refreshControl.beginRefreshing()
        }
    
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.pinToSuperview()
    }
    
    private func setDelegates() {
        calendarView.tableView.delegate = self
        calendarView.tableView.dataSource = self
        calendarView.tableView.register(CalendarTableViewCell.self)
    }
    
    private func subscribeToViewModel() {
        viewModel.onReceivedData = { [weak self] in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                if weakSelf.calendarView.refreshControl.isRefreshing {
                    weakSelf.calendarView.refreshControl.endRefreshing()
                }
                weakSelf.calendarView.tableView.reloadData()
            }
        }
        
        viewModel.onCalendarItemSelected = onDidSelectEvent
        viewModel.requestCalendarEvents()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

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
        return viewModel.cellHeight
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
    }
}
