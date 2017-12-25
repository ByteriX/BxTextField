//
//  BxTextFieldUITests.swift
//  BxTextFieldUITests
//
//  Created by Sergey Balalaev on 02/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import XCTest

class BxTextFieldUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllSimple() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.textFields["subdomain.byterix.com"]/*[[".cells.textFields[\"subdomain.byterix.com\"]",".textFields[\"subdomain.byterix.com\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.typeText("your.domain")
        tablesQuery/*@START_MENU_TOKEN@*/.cells.textFields["www.subdomain.byterix.com"]/*[[".cells.textFields[\"www.subdomain.byterix.com\"]",".textFields[\"www.subdomain.byterix.com\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        let textField = tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("next")
        
        let phoneTextField = tablesQuery/*@START_MENU_TOKEN@*/.cells.textFields["phone"]/*[[".cells.textFields[\"phone\"]",".textFields[\"phone\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        phoneTextField.tap()
        phoneTextField.typeText("71234567889")
        
        let righttoleftPhoneTextField = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element
        righttoleftPhoneTextField.tap()
        righttoleftPhoneTextField.typeText("0987654321")
        righttoleftPhoneTextField.doubleTap()
        righttoleftPhoneTextField.typeText("3334444")
        
        let textField3 = tablesQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textField).element
        textField3.tap()
        textField3.typeText("12345678899")
        
        let cardNumberTextField = tablesQuery/*@START_MENU_TOKEN@*/.cells.textFields["card number"]/*[[".cells.textFields[\"card number\"]",".textFields[\"card number\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        cardNumberTextField.tap()
        cardNumberTextField.tap()
        cardNumberTextField.typeText("1111222233334444")
        

    }
    
    func testDomain() {

        let app = XCUIApplication()
        let tablesQuery = app.tables
        let domainTextField = tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element
        domainTextField.tap()
        domainTextField.typeText("mail")
        domainTextField.tap()
        
        XCTAssertEqual(domainTextField.value as! String, "mail.byterix.com")
        
        let selectAllButton = app.menus.menuItems["Select All"]
        selectAllButton.tap()
        
        let cutButton = app.menus.menuItems["Cut"]
        cutButton.tap()
        domainTextField.typeText("phone")

        XCTAssertEqual(domainTextField.value as! String, "phone.byterix.com")

    }
    
}
