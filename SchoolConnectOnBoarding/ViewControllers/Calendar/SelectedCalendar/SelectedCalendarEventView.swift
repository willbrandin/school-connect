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
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Information:"
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
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Date and Time:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateAndTimeLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.text = "Location:"
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
        stackView.addArrangedSubview(dateAndTimeLabel)
        
        
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
        stackView.spacing = 15.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //MARK: - Init
    func customizeUI(_ calendarEvent: CalendarEvent?){
        setupStackViewConstraints()
        if let event = calendarEvent {
            backgroundColor = UIColor.white
            informationLabel.text = event.description
            dateAndTimeLabel.text = event.startDate
            locationLabel.text = event.location
        }
    }
    
    //MARK: - Methods
    func setupStackViewConstraints(){
        addSubview(bodyTextStackView)
        bodyTextStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        
        bodyTextStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
        bodyTextStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
    }
}
