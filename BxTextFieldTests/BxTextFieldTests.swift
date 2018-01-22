//
//  BxTextFieldTests.swift
//  BxTextFieldTests
//
//  Created by Sergey Balalaev on 02/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField

class BxTextFieldTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRightPattern() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.rightPatternText = ".byterix.com"
        textField.enteredText = "mail"
        XCTAssertEqual(textField.text!, "mail.byterix.com")
    }
    
    func testLeftPattern() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "www."
        textField.enteredText = "byterix.com"
        XCTAssertEqual(textField.text!, "www.byterix.com")
    }
    
    func testAllPattern() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "http://"
        textField.rightPatternText = "byterix.com"
        textField.enteredText = ""
        XCTAssertEqual(textField.text!, "http://byterix.com")
    }
    
    func testFormatting() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "+#(###)###-##-##"
        textField.enteredText = "78901234567"
        XCTAssertEqual(textField.text!, "+7(890)123-45-67")
    }

    
}
