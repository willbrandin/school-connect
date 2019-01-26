//
//  ContactViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ContactViewControllerProtocol: Presentable {
    var didSubmitForm: (() -> Void)? { get set }
}

protocol ContactFormDelegate: class {
    func didTapSubmit()
}

class ContactViewController: SNBaseViewController, ContactViewControllerProtocol {
    
    //MARK: - Properties
    var contactScreenView: ContactView!
    var viewModel: ContactViewModelProtocol!
    
    // MARK: - ContactViewControllerProtocol
    var didSubmitForm: (() -> Void)?
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = PageTitles.contact.rawValue
        viewModel = ContactViewModel()
        
    }
}

extension ContactViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for input in contactScreenView.inputs {
            input?.updateTitleForEditingText()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for input in contactScreenView.inputs {
            input?.updateTitleForEditingText()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == contactScreenView.phoneTextTitleView.textField {
            return textField.canFormatAsPhoneNumber(range: range, inputString: string)
        }
        return true
    }
    
}

extension ContactViewController: ContactFormDelegate {

    func didTapSubmit() {
        if formDataIsValid() {
            viewModel.submitContactForm()
            
        }
    }
    
    func formDataIsValid() -> Bool {
        
        if !contactScreenView.nameTextTitleView.textField.isValid {
            return false
        }
        
        if !contactScreenView.emailTextTitleView.textField.isValid {
            return false
        }
        
        if !contactScreenView.nameTextTitleView.textField.isValid {
            return false
        }
        
        guard let messageIsValid = contactScreenView.messageTextTitleView.floatingTextView?.isValid else { return false }
        
        if !messageIsValid {
            return false
        }
        
        return true
    }
    
}
