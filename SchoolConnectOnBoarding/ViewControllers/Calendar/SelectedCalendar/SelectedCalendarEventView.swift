//
//  SelectedCalendarEventView.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class SelectedCalendarEventView: UIView {

    //MARK: - Properties
    
    //MARK: - UI Elements
    
    lazy var informationTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Information"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var informationLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateAndTimeTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Date and Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startDateSubtitle: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Start Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endDateSubtitle: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "End Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startDateLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var endDateLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Location"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - StackView
    
    lazy var infoStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(informationTitleLabel)
        stackView.addArrangedSubview(informationLabel)
        
        
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var dateAndTimeStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(dateAndTimeTitleLabel)
        stackView.addArrangedSubview(startDateSubtitle)
        stackView.addArrangedSubview(startDateLabel)
        stackView.addArrangedSubview(endDateSubtitle)
        stackView.addArrangedSubview(endDateLabel)

        
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var locationStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(locationTitleLabel)
        stackView.addArrangedSubview(locationLabel)
        
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var bodyTextStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(infoStackView)
        
        stackView.addArrangedSubview(dateAndTimeStackView)
        
        stackView.addArrangedSubview(locationStackView)


        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var saveToCalendarButton: SNRoundedSchoolButton! = {
        let button = SNRoundedSchoolButton()
        button.setTitle("Save to Calendar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddToCalendar), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Init
    func customizeUI(_ calendarEvent: CalendarEvent?){
        setupStackViewConstraints()
        setupButtonConstraints()
        if let event = calendarEvent {
            backgroundColor = UIColor.white
            informationLabel.text = event.description
            locationLabel.text = event.location
            
            formatForStartAndEndDate(event)
            
        }
    }
    
    //MARK: - Methods
    func setupStackViewConstraints(){
        addSubview(bodyTextStackView)
        bodyTextStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
    }
    
    func setupButtonConstraints(){
        addSubview(saveToCalendarButton)
        saveToCalendarButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.0).isActive = true
        saveToCalendarButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        saveToCalendarButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        saveToCalendarButton.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
        

    }
    
    func formatForStartAndEndDate(_ event: CalendarEvent){
        if event.startDate != nil && event.endDate != nil {
            startDateLabel.text = event.startDate?.stringWithDateFormat(.weekDayAndTime)
            endDateLabel.text = event.endDate?.stringWithDateFormat(.weekDayAndTime)
            
            startDateSubtitle.isHidden = false
            endDateSubtitle.isHidden = false
            endDateLabel.isHidden = false
        } else {
            startDateLabel.text = event.startDate?.stringWithDateFormat(.weekDayAndTime)
            
            startDateSubtitle.isHidden = true
            endDateSubtitle.isHidden = true
            endDateLabel.isHidden = true
        }
    }

    @objc func handleAddToCalendar(){
        print("Saved")
    }

}
