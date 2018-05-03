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
        contactScreenView.messageTextTitleView.textView.textView.delegate = self
        
    }
    
 

}

extension ContactViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == contactScreenView.emailTextTitleView.textField {
            contactScreenView.emailTextTitleView.updateTitleForEditingText()
        } else if textField == contactScreenView.nameTextTitleView.textField {
            contactScreenView.nameTextTitleView.updateTitleForEditingText()
        } else if textField == contactScreenView.phoneTextTitleView.textField {
            contactScreenView.phoneTextTitleView.updateTitleForEditingText()
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == contactScreenView.emailTextTitleView.textField {
            contactScreenView.emailTextTitleView.updateTitleForEditingText()
        } else if textField == contactScreenView.nameTextTitleView.textField {
            contactScreenView.nameTextTitleView.updateTitleForEditingText()
        } else if textField == contactScreenView.phoneTextTitleView.textField {
            contactScreenView.phoneTextTitleView.updateTitleForEditingText()
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
            contactScreenView.messageTextTitleView.textView.textView.becomeFirstResponder()
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
        if textView == contactScreenView.messageTextTitleView.textView.textView {
            contactScreenView.messageTextTitleView.updateTitleForEditingText(isEditing: true)
        }
//        if textView == contactScreenView.messageTextView.textView {
//            let titleLbl = contactScreenView.messageTextTitle
//            if textView.text == "Message" {
//                textView.text = ""
//                textView.textColor = .black
//                titleLbl?.fadeTransition(0.4)
//                titleLbl?.textColor = SCColors.scBlue
//                titleLbl?.text = "Message"
//            }
//        }
        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == contactScreenView.messageTextTitleView.textView.textView {
            contactScreenView.messageTextTitleView.updateTitleForEditingText(isEditing: false)
        }
//        let titleLbl = contactScreenView.messageTextTitle
//        if textView.text == "" {
//
//            textView.text = "Message"
//            textView.textColor = UIColor(hex: "C7C7CD").withAlphaComponent(0.7)
//            titleLbl?.fadeTransition(0.4)
//            //titleLbl?.textColor = UIColor.lightGray
//            titleLbl?.text = ""
//        }
//        titleLbl?.textColor = UIColor.lightGray
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
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
                let message = contactScreenView.messageTextTitleView.textView.textView.text else {
                
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
        
        if !contactScreenView.messageTextTitleView.textView.textView.isValid {
            return false
        }
        
        return true
    }
    
}


