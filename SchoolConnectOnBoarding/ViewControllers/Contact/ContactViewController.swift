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
                    titleLbl?.textColor = SCColors.scBlue
                    contactScreenView.nameTextField.placeholder = ""
                }
            }
        } else if textField == contactScreenView.emailTextField {
            let titleLbl = contactScreenView.emailFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = "E-Mail"
                    titleLbl?.textColor = SCColors.scBlue
                    contactScreenView.emailTextField.placeholder = ""
                }
            }
        } else if textField == contactScreenView.phoneNumberTextField {
            let titleLbl = contactScreenView.phoneNumberFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)
                    titleLbl?.text = "Phone Number"
                    titleLbl?.textColor = SCColors.scBlue
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
                    titleLbl?.textColor = UIColor.lightGray

                    contactScreenView.nameTextField.placeholder = ""
                }
            }
        } else if textField == contactScreenView.emailTextField {
            let titleLbl = contactScreenView.emailFieldTitle
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = ""
                    contactScreenView.emailTextField.placeholder = "E-Mail"
                } else {
                    titleLbl?.fadeTransition(0.4)

                    titleLbl?.text = "E-Mail"
                    //VALIDATE
                    if contactScreenView.emailTextField.isValid {
                        titleLbl?.textColor = SCColors.scGreen
                    } else {
                        titleLbl?.textColor = SCColors.scRed
                    }
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
                    //VALIDATE
                    if contactScreenView.phoneNumberTextField.isValid {
                        titleLbl?.textColor = SCColors.scGreen
                    } else {
                        titleLbl?.textColor = SCColors.scRed
                    }
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
            contactScreenView.messageTextView.textView.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == contactScreenView.phoneNumberTextField {
            return textField.canFormatAsPhoneNumber(range: range, inputString: string)
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
                titleLbl?.textColor = SCColors.scBlue
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
            //titleLbl?.textColor = UIColor.lightGray
            titleLbl?.text = ""
        }
        titleLbl?.textColor = UIColor.lightGray
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
            
            guard let name = contactScreenView.nameTextField.text, let email = contactScreenView.emailTextField.text, let phoneNumber = contactScreenView.emailTextField.text, let message = contactScreenView.messageTextView.textView.text else {
                
                
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
        
        if !contactScreenView.nameTextField.isValid {
            return false
        }
        
        if !contactScreenView.emailTextField.isValid {
            return false
        }
        
        if !contactScreenView.phoneNumberTextField.isValid {
            return false
        }
        
        if !contactScreenView.messageTextView.textView.isValid {
            return false
        }
        
        return true
    }
    
}


