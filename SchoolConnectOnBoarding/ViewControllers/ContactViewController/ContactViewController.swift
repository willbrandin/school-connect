//
//  ContactViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol ContactViewControllerProtocol: Presentable {
    var didSubmitForm: (() -> Void)? { get set }
}

class ContactViewController: SNBaseViewController, ContactViewControllerProtocol {
    
    // MARK: - Properties
    var viewModel: ContactViewModelProtocol = ContactViewModel()
    
    lazy var contactTitleLabel: UILabel! = {
        let label = UILabel()
        label.font = SCFont.heroTitle
        label.text = PageTitles.contactSubtitle.rawValue
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: SkyFloatingLabelTextField! = {
        let textField = SkyFloatingLabelTextField(frame: .zero)
        textField.placeholder = "Name"
        return textField
    }()
    
    private lazy var phoneNumberTextField: SkyFloatingLabelTextField! = {
        let textField = SkyFloatingLabelTextField(frame: .zero)
        textField.placeholder = "Email"
        return textField
    }()
    
    private lazy var emailTextField: SkyFloatingLabelTextField! = {
        let textField = SkyFloatingLabelTextField(frame: .zero)
        textField.placeholder = "Phone Number"
        return textField
    }()

    lazy var submitButton: CustomButton! = {
        let button = CustomButton(content: CustomButtonContent(title: "Submit"))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.actionHandler = { [weak self] _ in
            self?.didSubmitForm?()
        }
        return button
    }()
    
    lazy var mainStackView: UIStackView! = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(contactTitleLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - ContactViewControllerProtocol
    var didSubmitForm: (() -> Void)?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setMargins(top: Style.Layout.innerSpacing,
                        leading: Style.Layout.margin,
                        bottom:  Style.Layout.innerSpacing,
                        trailing:  Style.Layout.margin)
        
        title = PageTitles.contact.rawValue
        view.backgroundColor = .white
        view.insetsLayoutMarginsFromSafeArea = true
        
        view.addSubview(mainStackView)
        mainStackView.pinToTopMargin()
        mainStackView.pinToLeadingAndTrailingMargins()
        
        view.addSubview(submitButton)
        submitButton.pinToLeadingAndTrailingMargins()
        submitButton.pinToBottomMargin()
    }
}
