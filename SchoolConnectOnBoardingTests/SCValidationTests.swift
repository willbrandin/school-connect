//
//  SCValidationTests.swift
//  SchoolConnectOnBoardingTests
//
//  Created by William Brandin on 4/12/18.
//  Copyright © 2018 William Brandin. All rights reserved.
//

import XCTest
@testable import SchoolConnectOnBoarding


class SCValidationTests: XCTestCase {
    
    var textField: SCFloatingTextField?
    var textView: SCFloatingTextView?
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        textField = nil
        textView = nil
        super.tearDown()
    }
    
    //MARK: - Email Test
    func testEmailValidationPass(){
        textField = SCFloatingTextField(type: .email)
        textField?.text = "test@gmail.com"
        XCTAssert((textField?.isValid)!, "Text field should be valid")
    }
    func testEmailValidationFail(){
        textField = SCFloatingTextField(type: .email)
        textField?.text = "bob@gm"
        XCTAssertFalse((textField?.isValid)!, "Text field should not be valid")
    }
    
    func testEmailValidationFailWhenNil(){
        textField = SCFloatingTextField(type: .email)
        textField?.text = nil
        XCTAssertFalse((textField?.isValid)!, "Text field should not be valid")
    }
    
    func testEmailValidationRegexPass(){
        let testText = "test@gmail.com"
        XCTAssert(String.isEmailValid(text: testText), "Email should be valid")
    }
    
    func testEmailValidationRegexFail(){
        let testText = "tet@gma"
        XCTAssertFalse(String.isEmailValid(text: testText), "Email should not be valid")
    }
    
    //MARK: - Phone number test
    
    func testPhoneValidationPass(){
        textField = SCFloatingTextField(type: .phoneNumber)
        textField?.text = "1234567890"
        XCTAssert((textField?.isValid)!, "Text field should be valid")
    }
    func testPhoneValidationFail(){
        textField = SCFloatingTextField(type: .phoneNumber)
        textField?.text = "123-456-7890"//should fail?
        XCTAssertFalse((textField?.isValid)!, "Text field should not be valid")
    }
    
    func testPhoneValidationRegexPass(){
        let testText = "1234567890"
        XCTAssert(String.isPhoneNumberValid(text: testText), "Phone text should be valid")
    }
    
    func testPhoneValidationRegexFail(){
        let testText = "12345678901234"
        XCTAssertFalse(String.isPhoneNumberValid(text: testText), "Phone text should not be valid")
    }
    
    //MARK: - Message
    func testMessageValidationPass(){
        textView = SCFloatingTextView(type: .message)
        textView?.textView.text = "Hello my name is a persons name"
        XCTAssert((textView?.textView.isValid)!, "Text View should be valid")
    }
    func testMessageValidationFail(){
        textView = SCFloatingTextView(type: .message)
        textView?.textView.text = ""
        XCTAssertFalse((textView?.textView.isValid)!, "Text view should not be valid")
    }
    func testMessageNilValidationFail(){
        textView = SCFloatingTextView(type: .message)
        textView?.textView.text = nil
        XCTAssertFalse((textView?.textView.isValid)!, "Text view should not be valid")
    }
    
    func testMessageValidationRegexPass(){
        let testText = "This should pass cause 123"
        XCTAssert(String.isMessageValid(text: testText), "Message text should be valid")
    }
    
    func testMessageValidationRegexFail(){
        let testText = ""
        XCTAssertFalse(String.isMessageValid(text: testText), "Message text should not be valid")
    }
    
    //MARK: - Name
    func testNameValidationPass(){
        textField = SCFloatingTextField(type: .name)
        textField?.text = "William Brandin"
        XCTAssert((textField?.isValid)!, "Text Field should be valid")
    }
    func testNameValidationFail(){
        textField = SCFloatingTextField(type: .name)
        textField?.text = ""
        XCTAssertFalse((textField?.isValid)!, "Text field should not be valid")
    }
    func testNameNilValidationFail(){
        textField = SCFloatingTextField(type: .name)
        textField?.text = nil
        XCTAssertFalse((textField?.isValid)!, "Text field should not be valid")
    }
    
    func testNameValidationRegexPass(){
        let testText = "William Brandin"
        XCTAssert(String.isValidName(text: testText), "Name text should be valid")
    }
    
    func testNameValidationRegexFail(){
        let testText = ""
        XCTAssertFalse(String.isValidName(text: testText), "Name text should not be valid")
    }
    
    func testNameWithNumbersValidationRegexFail(){
        let testText = "William 1234"
        XCTAssertFalse(String.isValidName(text: testText), "Name text should not be valid")
    }
    
    
}
