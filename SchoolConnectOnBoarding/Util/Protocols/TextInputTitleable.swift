//
//  TextInputTitleable.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 5/3/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit

protocol TextInputTitleable {
    var textInputTitle: UILabel! { get set }
    //func updateTitleColorsForValidation()
}


extension TextInputTitleable where Self: WBFloatingTitledTextField {
    /**
     Configures the title appearence for the text field.
     *To be called on textDid(Begin/End)Editing methods*
     
     Cases:
     * isEmpty
     * Title should be "" and placeholder will the "Title".
     * isEditing:
     * Title is "Title" and placeholder is gone cause editing. Title is blue.
     */
    func updateTitleForEditingText(){
        if textField.isEditing {
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    textInputTitle.fadeTransition(0.4)
                    
                    textInputTitle.text = textField.validationType.rawValue
                    textInputTitle.textColor = SCColors.scBlue
                    textField.placeholder = ""
                }
            }
        } else {
            if let fieldText = textField.text {
                if fieldText.count == 0 {
                    textInputTitle?.fadeTransition(0.4)
                    
                    textInputTitle?.text = ""
                    textField.placeholder = textField.validationType.rawValue
                } else {
                    textInputTitle?.fadeTransition(0.4)
                    
                    textInputTitle?.text = textField.validationType.rawValue
                    //textFieldTitle?.textColor = UIColor.lightGray
                    updateTitleColorsForValidation()
                    textField.placeholder = ""
                }
            }
        }
        
        
    }
    
    /**
     Called after textFieldDidEndEditing.
     
     Cases:
     * isValid
     * Title will be shade of green.
     * isInValid
     * Title will be red.
     */
    private func updateTitleColorsForValidation(){
        //Contains
        if textField.isValid {
            textInputTitle.textColor = SCColors.scGreen
        } else {
            textInputTitle.textColor = SCColors.scRed
        }
    }
}

extension TextInputTitleable where Self: WBFloatingTitledTextView {
    /**
     Configures the title appearence for the text field.
     *To be called on textDid(Begin/End)Editing methods*
     
     Cases:
     * isEmpty
     * Title should be "" and placeholder will the "Title".
     * isEditing:
     * Title is "Title" and placeholder is gone cause editing. Title is blue.
     */
    func updateTitleForEditingText(isEditing: Bool){
        if isEditing {
            let inputView = textView.textView
            let titleLbl = textInputTitle
            
            if inputView?.text == textView.textView.validationType.rawValue {
                inputView?.text = ""
                inputView?.textColor = .black
                titleLbl?.fadeTransition(0.4)
                titleLbl?.textColor = SCColors.scBlue
                titleLbl?.text = textView.textView.validationType.rawValue
            }
            
        } else {
            let inputView = textView.textView
            let titleLbl = textInputTitle
            if inputView?.text == "" {
    
                inputView?.text = textView.textView.validationType.rawValue
                inputView?.textColor = SCColors.textFieldPlaceholder
                titleLbl?.fadeTransition(0.4)
                //titleLbl?.textColor = UIColor.lightGray
                titleLbl?.text = ""
            }
            titleLbl?.textColor = UIColor.lightGray
        }
        
        
    }
    
    /**
     Called after textFieldDidEndEditing.
     
     Cases:
     * isValid
     * Title will be shade of green.
     * isInValid
     * Title will be red.
     */
    private func updateTitleColorsForValidation(){
        //Contains
        if textView.textView.isValid {
            textInputTitle.textColor = SCColors.scGreen
        } else {
            textInputTitle.textColor = SCColors.scRed
        }
    }
}

