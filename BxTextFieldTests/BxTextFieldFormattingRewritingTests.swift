//
//  BxTextFieldFormattingRewritingTests.swift
//  BxTextFieldTests
//
//  Created by Sergan on 03/02/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField

class BxTextFieldFormattingRewritingTests: XCTestCase {
    
    func testLeftToRight() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "+#(###)###-##-##"
        textField.isFormattingRewriting = true
        textField.enteredText = "1234567890123"
        XCTAssertEqual(textField.text!, "+1(234)567-89-01")
        textField.enteredText = "12345678901"
    }
    
    func testRightToLeft() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "+#(###)###-##-##"
        textField.formattingDirection = .rightToLeft
        textField.isFormattingRewriting = true
        textField.enteredText = "7012345678901"
        XCTAssertEqual(textField.text!, "+1(234)567-89-01")
        textField.enteredText = "12345678901"
    }
    
    func testRewriting() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "$ "
        textField.formattingTemplate = "###"
        textField.isFormattingRewriting = true
        textField.formattingDirection = .rightToLeft
        textField.enteredText = "12345"
        XCTAssertEqual(textField.text!, "$ 345")
        textField.enteredText = "09"
        XCTAssertEqual(textField.text!, "$ 09")
        
        textField.enteredText = "xxxxxx"
        XCTAssertEqual(textField.text!, "$ xxx")
        
        textField.formattingDirection = .leftToRight
        textField.enteredText = "12345"
        XCTAssertEqual(textField.text!, "$ 123")
    }

    func testNotRewriting() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "$ "
        textField.formattingTemplate = "###"
        textField.isFormattingRewriting = false
        textField.formattingDirection = .rightToLeft
        textField.enteredText = "12345"
        XCTAssertEqual(textField.text!, "$ 345")
        textField.enteredText = "09"
        XCTAssertEqual(textField.text!, "$ 09")
        
        textField.enteredText = "xxxxxx"
        XCTAssertEqual(textField.text!, "$ xxx")
        
        textField.formattingDirection = .leftToRight
        textField.enteredText = "12345"
        XCTAssertEqual(textField.text!, "$ 123")
    }
    
    
}
