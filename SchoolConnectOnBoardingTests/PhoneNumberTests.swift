//
//  PhoneNumberTests.swift
//  GreyhoundTests
//
//  Created by Brandin, Will on 4/17/18.
//  Copyright © 2017 Greyhound. All rights reserved.
//

import XCTest
import UIKit

@testable import SchoolConnectOnBoarding

class GHUtilTests: XCTestCase {
    
    var input = "1234567890" as NSString
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectNumber(){
        let newVal = String.formatStringAsPhoneNumber(input.length, input)
        let expected = "123-456-7890"
        XCTAssertTrue(newVal == expected)
    }
    
    func testIsValidPhoneNumber(){
        let newVal = String.formatStringAsPhoneNumber(input.length, input)
        XCTAssertTrue(String.isPhoneNumberValid(text: newVal))
    }
    
    func testIsNotValidPhoneNumber(){
        input = "123456789"
        let newVal = String.formatStringAsPhoneNumber(input.length, input)
        XCTAssertFalse(String.isPhoneNumberValid(text: newVal))
    }
    
    func testNumberOfDigitsEntered(){
        input = "12345678902222"
        let value = input as String
        XCTAssertFalse(value.isValidNumberCountForPhoneNumber(value.count))
        
        input = "1234567890"
        let value2 = input as String
        XCTAssertTrue(value2.isValidNumberCountForPhoneNumber(value2.count))
    }
    
    func testDeletionOfADigitInPhoneNumber(){
        //Deletes Digit
        input = "124567890"
        let displayedNumber = String.formatStringAsPhoneNumber(input.length, input)
        let expected = "124-567-890"
        XCTAssertTrue(displayedNumber == expected)
        
        //Adds Digit in place of previous
        input = "1204567890"
        let newNumber = String.formatStringAsPhoneNumber(input.length, input)
        let newExpectation = "120-456-7890"
        XCTAssertTrue(newNumber == newExpectation)
    }
}
