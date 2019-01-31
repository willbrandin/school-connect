//
//  TextInputTitleable.swift
//  SchoolConnectOnBoarding
//
//  Created by William Brandin on 5/3/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import UIKit
/**
 Allows classes with a textField/TextView to have an animatable and colorable title.
 Protocol methods can be called from a ViewController and change the attributes of the title.
 ie. An invalid entry on an email text field will change the title to red.
 */
protocol TextInputTitleable {
    var text: String? { get set }
    var textInputTitle: UILabel! { get set }
}


extension TextInputTitleable where Self: WBFloatingTitledTextField {
    /**
     Configures the title appearence for the text field.
     *To be called on textDid(Begin/End)Editing methods.*
     
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
     When the text view is finished editing, the title can change color to indicate valid/invalid state.
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
     Configures the title appearence for the text view.
     *To be called on `textDid(Begin/End)Editing` methods.*
     Cases:
     * isEmpty
        * Title should be "" and placeholder will the "Title".
     * isEditing:
        * Title is "Title" and placeholder is gone cause editing. Title is blue.
     
     - parameters:
        - isEditing: Boolean determines whether the textView should update for begining to edit or editting has completed.
     */
    func updateTitleForEditingText(isEditing: Bool){
        if isEditing {
            let inputView = floatingTextView
            let titleLbl = textInputTitle
            
            if inputView?.text == inputView?.validationType.rawValue {
                inputView?.text = ""
                inputView?.textColor = .black
                titleLbl?.fadeTransition(0.4)
                titleLbl?.textColor = SCColors.scBlue
                titleLbl?.text = inputView?.validationType.rawValue
            }
            
        } else {
            let inputView = floatingTextView
            let titleLbl = textInputTitle
            if inputView?.text == "" {
    
                inputView?.text = inputView?.validationType.rawValue
                inputView?.textColor = SCColors.textFieldPlaceholder
                titleLbl?.fadeTransition(0.4)
                //titleLbl?.textColor = UIColor.lightGray
                updateTitleColorsForValidation()
                titleLbl?.text = ""
            }
            titleLbl?.textColor = UIColor.lightGray
        }
    }
    
    /**
     When the text view is finished editing, the title can change color to indicate valid/invalid state.
     */
    private func updateTitleColorsForValidation(){
        //Contains
        guard let isValid = floatingTextView?.isValid else {
            textInputTitle.textColor = SCColors.scRed
            return
        }
        if isValid {
            textInputTitle.textColor = SCColors.scGreen
        } else {
            textInputTitle.textColor = SCColors.scRed
        }
    }
}
