//
//  ContactViewModel.swift
//  SchoolConnectOnBoarding
//
//  Created by Will Brandin on 12/22/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol ContactViewModelProtocol {
    
    func submitContactForm()
    
    func nameTextFieldChanged(_ text: String)
    func emailTextFieldChanged(_ text: String)
    func phoneTextFieldChanged(_ text: String)
    func messageTextViewTextChanged(_ text: String)
}

class ContactViewModel: ContactViewModelProtocol {
    
    private var name: String?
    private var email: String?
    private var phoneNumber: String?
    private var message: String?
    
    var contactFormModel: ContactForm? {
        guard let name = name,
            let email = email,
            let phoneNumber = phoneNumber,
            let message = message else {
                return nil
        }
        
        return ContactForm(name: name, email: email, phoneNumber: phoneNumber, message: message)
    }
    
    func nameTextFieldChanged(_ text: String) {
        name = text
    }
    
    func emailTextFieldChanged(_ text: String) {
        email = text
    }
    
    func phoneTextFieldChanged(_ text: String) {
        phoneNumber = text.removeSpecialCharactersFromText()
    }
    
    func messageTextViewTextChanged(_ text: String) {
        message = text
    }

    func submitContactForm() {
        postContactFormWebService { [weak self] result in
            self?.handleNetworkingResult(with: result)
        }
    }
    
    private func postContactFormWebService(completion: @escaping (Result<ContactForm, APIError>) -> Void){
        guard let contactForm = contactFormModel else { return }
        let networkManager = NetworkManager.sharedInstance
        let endpoint = SchoolConnectAPI.sendMessage(data: contactForm)
        
        networkManager.request(for: endpoint, ContactForm.self) { (result) in
            completion(result)
        }
    }
    
    private func handleNetworkingResult(with result: Result<ContactForm, APIError>) {
        switch result {
        case .success:
            print("success")
        case .error:
            print("error")
        }
    }
}
