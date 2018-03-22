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
            if let textField = input {
                textField.delegate = self
            }
        }
        contactScreenView.messageTextView.textView.delegate = self
        
    }
    
 

}

extension ContactViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == contactScreenView.nameTextField {
            let titleLbl = contactScreenView.nameFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = "Name"
                    contactScreenView.nameTextField.placeholder = ""
                }
            }
        } else if textField == contactScreenView.emailTextField {
            let titleLbl = contactScreenView.emailFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = "E Mail"
                    contactScreenView.emailTextField.placeholder = ""
                }
            }
        } else if textField == contactScreenView.phoneNumberTextField {
            let titleLbl = contactScreenView.phoneNumberFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)
                    titleLbl?.text = "Phone Number"
                    contactScreenView.phoneNumberTextField.placeholder = ""
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == contactScreenView.nameTextField {
            let titleLbl = contactScreenView.nameFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = ""
                    contactScreenView.nameTextField.placeholder = "Name"
                } else {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = "Name"
                    contactScreenView.nameTextField.placeholder = ""
                }
            }
        } else if textField == contactScreenView.emailTextField {
            let titleLbl = contactScreenView.emailFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = ""
                    contactScreenView.emailTextField.placeholder = "E Mail"
                } else {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = "E Mail"
                    contactScreenView.emailTextField.placeholder = ""
                }
            }
        }
        if textField == contactScreenView.phoneNumberTextField {
            let titleLbl = contactScreenView.phoneNumberFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)
                    titleLbl?.text = ""
                    contactScreenView.phoneNumberTextField.placeholder = "Phone Number"
                } else {
                    titleLbl?.fadeTransition(0.4)
                    titleLbl?.text = "Phone Number"
                    contactScreenView.phoneNumberTextField.placeholder = ""
                }
            }
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == contactScreenView.nameTextField {
            contactScreenView.nameTextField.resignFirstResponder()
            contactScreenView.emailTextField.becomeFirstResponder()
        } else if textField == contactScreenView.emailTextField {
            contactScreenView.emailTextField.resignFirstResponder()
            contactScreenView.phoneNumberTextField.becomeFirstResponder()
        } else if textField == contactScreenView.phoneNumberTextField {
            contactScreenView.phoneNumberTextField.resignFirstResponder()
            contactScreenView.messageTextView.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension ContactViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView == contactScreenView.messageTextView.textView {
            let titleLbl = contactScreenView.messageTextTitle
            if textView.text == "Message" {
                textView.text = ""
                textView.textColor = .black
                titleLbl?.fadeTransition(0.4)

                titleLbl?.text = "Message"
            }
        }
        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let titleLbl = contactScreenView.messageTextTitle
        if textView.text == "" {

            textView.text = "Message"
            textView.textColor = UIColor(hex: "C7C7CD").withAlphaComponent(0.7)
            titleLbl?.fadeTransition(0.4)

            titleLbl?.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }

    
    
}


extension ContactViewController: ContactFormDelegate {
    //text field validation delegate from cocoacasts?
    func didTapSubmit() {
        //
    }
    
}


