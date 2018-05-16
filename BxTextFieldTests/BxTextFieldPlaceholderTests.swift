//
//  BxTextFieldPlaceholderTests.swift
//  BxTextFieldTests
//
//  Created by Sergey Balalaev on 16/05/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField

class BxTextFieldPlaceholderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPlaceholderWithPatterns() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "www."
        textField.rightPatternText = ".byterix.com"
        textField.placeholderText = "domain"
        textField.isPlaceholderPatternShown = true
        XCTAssertEqual(textField.placeholder!, "www.domain.byterix.com")
        XCTAssertEqual(textField.enteredText, "")
        XCTAssertEqual(textField.text!, "")
        textField.enteredText = "mail"
        XCTAssertEqual(textField.placeholder!, "www.domain.byterix.com")
        XCTAssertEqual(textField.enteredText, "mail")
        XCTAssertEqual(textField.text!, "www.mail.byterix.com")
    }
    
    func testPlaceholderWithoutPatterns() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.leftPatternText = "www."
        textField.rightPatternText = ".byterix.com"
        textField.placeholderText = "domain"
        textField.isPlaceholderPatternShown = false
        XCTAssertEqual(textField.placeholder!, "domain")
        XCTAssertEqual(textField.enteredText, "")
        XCTAssertEqual(textField.text!, "")
        textField.enteredText = "mail"
        XCTAssertEqual(textField.placeholder!, "domain")
        XCTAssertEqual(textField.enteredText, "mail")
        XCTAssertEqual(textField.text!, "www.mail.byterix.com")
    }
}
