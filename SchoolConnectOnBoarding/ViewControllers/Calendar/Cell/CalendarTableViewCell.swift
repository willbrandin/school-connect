//
//  CalendarTableViewCell.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/14/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    //MARK: - Properties
    static var cellId = "CalendarCell"
    var cardView: CalendarCardView!

    //MARK: - UI Elements
    
    
    //MARK: - Life Cycle and Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        makeShadow()
    }
    
    //MARK: - Methods
    
    func configureCell(_ calendarEvent: CalendarEvent?){
        setupCardViewConstraints()
        self.contentView.backgroundColor = UIColor.gray
        if let event = calendarEvent {
            cardView.calendarEvent = event
            cardView.customizeUI()
        }
       
    }
    
    func setupCardViewConstraints(){
        cardView = CalendarCardView()
        addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15.0).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15.0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20.0).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20.0).isActive = true
    }

    func updateCornerRadius() {
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
    }
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 8.0
    }
}
