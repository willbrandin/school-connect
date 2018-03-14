//
//  CalendarCardView.swift
//  
//
//  Created by William Brandin on 3/14/18.
//

import UIKit

class CalendarCardView: UIView {

    //MARK: - Properties
    var calendarEvent: CalendarEvent?
    
    
    //MARK: - UI Elements
    
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26.0, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var eventDateLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .bold)
        label.textColor = UIColor.scGrayText()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var arrowImageView: CalendarCellSideButtonView! = {
        let arrowImg = CalendarCellSideButtonView()
        arrowImg.backgroundColor = UIColor.white
        arrowImg.clipsToBounds = false
        arrowImg.contentMode = .scaleAspectFit
        return arrowImg
    }()
    
    //MARK: - StackViews
    lazy var mainStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(textStackView)
        stackView.addArrangedSubview(arrowImageView)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var textStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(eventDateLabel)
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //MARK: - Methods
    
    func customizeUI(){
         self.backgroundColor = UIColor.white
        setupMainStackViewConstraints()
        titleLabel.text = "Bake sale"
        eventDateLabel.text = "12/15/1993"
       
        updateCornerRadius()
    }
    
    func setupMainStackViewConstraints(){
        addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
        setupSideButtonViewConstraints()
    }
    
    func setupSideButtonViewConstraints(){
        arrowImageView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor).isActive = true
    }
    
    func updateCornerRadius() {
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
    }

}
