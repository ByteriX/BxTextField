//
//  BxTextFieldFormattingTests.swift
//  BxTextField
//
//  Created by Sergan on 22/01/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField

class BxTextFieldFormattingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
        
    func testChangedDirection() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "+#(###)###-##-##"
        textField.formattingDirection = .rightToLeft
        textField.enteredText = "78901234567"
        XCTAssertEqual(textField.text!, "+7(890)123-45-67")
    }
    
    func testFormatChange1() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "+#(###)###-##-##"
        textField.formattingReplacementChar = "*"
        textField.enteredText = "78901234567"
        XCTAssertNotEqual(textField.text!, "+7(890)123-45-67")
        XCTAssertEqual(textField.text!, textField.formattingTemplate)
        
        textField.formattingTemplate = "+*(***)***-**-**"
        textField.enteredText = "78901234567"
        XCTAssertEqual(textField.text!, "+7(890)123-45-67")
    }
    
    func testFormatChange2() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        textField.formattingTemplate = "+%(%%%)%%%-%%-%%"
        textField.formattingReplacementChar = "%"
        textField.enteredText = "78901234567"
        XCTAssertEqual(textField.text!, "+7(890)123-45-67")
    }
    
    func testRightToLeftDirection() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "#.##"
        textField.formattingDirection = .rightToLeft
        textField.enteredText = "1"
        XCTAssertEqual(textField.text!, "1")
        textField.enteredText = "12"
        XCTAssertEqual(textField.text!, ".12")
        textField.enteredText = "123"
        XCTAssertEqual(textField.text!, "1.23")
    }
    
    func testLeftToRightDirection() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "#.##"
        textField.formattingDirection = .leftToRight
        textField.enteredText = "1"
        XCTAssertEqual(textField.text!, "1")
        textField.enteredText = "12"
        XCTAssertEqual(textField.text!, "1.2")
        textField.enteredText = "123"
        XCTAssertEqual(textField.text!, "1.23")
    }
    
    func testLeftPattern() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "$ "
        textField.formattingTemplate = "###"
        textField.formattingDirection = .rightToLeft
        textField.enteredText = "123"
        XCTAssertEqual(textField.text!, "$ 123")
        textField.enteredText = ""
        XCTAssertEqual(textField.text!, "$ ")
    }
    
}
