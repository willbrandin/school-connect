//
//  ContactViewController.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 3/13/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ContactFormDelegate: class {
    func didTapSubmit()
}

class ContactViewController: SNBaseViewController {
    
    //MARK: - Properties
    var contactScreenView: ContactView!
    

    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = PageTitles.contact.rawValue
        
        setupContactView()
        setDelegates()
    
    }
    
    //MARK: - Methods
    func setupContactView(){
        contactScreenView = ContactView()
        contactScreenView.customizeUI()
        contactScreenView.formDelegate = self
        self.view.addSubview(contactScreenView)
        
        contactScreenView.translatesAutoresizingMaskIntoConstraints = false
        contactScreenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contactScreenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        contactScreenView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        contactScreenView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setDelegates(){
        for input in contactScreenView.inputs {
            if let textField = input?.textField {
                textField.delegate = self
            }
        }
        contactScreenView.messageTextTitleView.floatingTextView?.delegate = self
        
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == contactScreenView.nameTextTitleView.textField {
            contactScreenView.nameTextTitleView.textField.resignFirstResponder()
            contactScreenView.emailTextTitleView.textField.becomeFirstResponder()
        } else if textField == contactScreenView.emailTextTitleView.textField {
            contactScreenView.emailTextTitleView.textField.resignFirstResponder()
            contactScreenView.phoneTextTitleView.textField.becomeFirstResponder()
        } else if textField == contactScreenView.phoneTextTitleView.textField {
            contactScreenView.phoneTextTitleView.textField.resignFirstResponder()
            contactScreenView.messageTextTitleView.floatingTextView?.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == contactScreenView.phoneTextTitleView.textField {
            return textField.canFormatAsPhoneNumber(range: range, inputString: string)
        }
        return true
    }
    
}

extension ContactViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == contactScreenView.messageTextTitleView.floatingTextView {
            contactScreenView.messageTextTitleView.updateTitleForEditingText(isEditing: true)
        }

        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == contactScreenView.messageTextTitleView.floatingTextView {
            contactScreenView.messageTextTitleView.updateTitleForEditingText(isEditing: false)
        }

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if textView.text.count >= 200 && range.location < 199 {
//            return false
//        }
        return true
    }

    
    
}


extension ContactViewController: ContactFormDelegate {

    //Web services to POST the message.
    func didTapSubmit() {
        //construct contact form
        //POST contact form
        
        if formDataIsValid() {
            
            guard let name = contactScreenView.nameTextTitleView.textField.text,
                let email = contactScreenView.emailTextTitleView.textField.text,
                let phoneNumber = contactScreenView.phoneTextTitleView.textField.text,
                let message = contactScreenView.messageTextTitleView.floatingTextView?.text else {
                
                return
            }
            
            let contactForm = ContactForm(name: name, email: email, phoneNumber: phoneNumber, message: message)
            contactForm.postContactForm()
            view.backgroundColor = SCColors.scGreen
            
        } else {
            view.backgroundColor = SCColors.scRed
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


