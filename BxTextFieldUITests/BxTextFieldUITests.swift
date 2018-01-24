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
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllSimple()
    {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.cells.textFields["subdomain.byterix.com"].tap()
        tablesQuery.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.typeText("your.domain")
        tablesQuery.cells.textFields["www.subdomain.byterix.com"].tap()
        
        let textField = tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("next")
        
        let phoneTextField = tablesQuery.cells.textFields["phone"]
        phoneTextField.tap()
        phoneTextField.typeText("71234567889")
        
        let righttoleftPhoneTextField = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element
        righttoleftPhoneTextField.tap()
        righttoleftPhoneTextField.typeText("0987")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " - 09 - 87")
        righttoleftPhoneTextField.typeText("654321")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " (098) 765 - 43 - 21")
        
        let textField3 = tablesQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textField).element
        textField3.tap()
        textField3.typeText("12345678899")
        
        let cardNumberTextField = tablesQuery.cells.textFields["card number"]
        cardNumberTextField.tap()
        cardNumberTextField.typeText("1111222233334444")
    }
    
    func testDomain()
    {
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
    
    func testRightToleft()
    {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        let righttoleftPhoneTextField = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element
        
        righttoleftPhoneTextField.tap()
        righttoleftPhoneTextField.typeText("0")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "0")
        
        righttoleftPhoneTextField.typeText("9")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " - 09")
        
        righttoleftPhoneTextField.typeText("8")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "0 - 98")
        
        righttoleftPhoneTextField.typeText("7")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " - 09 - 87")
        
        righttoleftPhoneTextField.typeText("65432")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "09) 876 - 54 - 32")
        
        righttoleftPhoneTextField.typeText("1")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " (098) 765 - 43 - 21")
        
        // select only last symboles, because space symbole is seporator
        righttoleftPhoneTextField.doubleTap()
        righttoleftPhoneTextField.typeText("3334444")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+6 (543) 333 - 44 - 44")
        
    }
    
    func testRightToleftCursorSelect()
    {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        let righttoleftPhoneTextField = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element
        
        righttoleftPhoneTextField.tap()
        righttoleftPhoneTextField.typeText("09876543210")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+0 (987) 654 - 32 - 10")
        
        righttoleftPhoneTextField.doubleTap()

        // It doesn't work on iPhone SE / Please use absolute value of coordinates.
        //righttoleftPhoneTextField.coordinate(withNormalizedOffset: CGVector(dx:0.95, dy:0.5)).press(forDuration: 1, thenDragTo: righttoleftPhoneTextField.coordinate(withNormalizedOffset: CGVector(dx:0.3, dy:0.5)))
        
        // It is better solution
        let coordinate = righttoleftPhoneTextField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0.5))
        coordinate.withOffset(CGVector(dx:-20, dy:0)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-300, dy:0)))
        
        righttoleftPhoneTextField.typeText("098765")
        
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "09 - 87 - 65")
        
        righttoleftPhoneTextField.typeText("4321")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " (098) 765 - 43 - 21")
        righttoleftPhoneTextField.typeText("0")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+0 (987) 654 - 32 - 10")
        righttoleftPhoneTextField.typeText("9")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+9 (876) 543 - 21 - 09")
        
    }
    
    func testRightToleftCursorMove()
    {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        let righttoleftPhoneTextField = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element

        righttoleftPhoneTextField.tap()
        righttoleftPhoneTextField.typeText("09876543210")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+0 (987) 654 - 32 - 10")

        let coordinate = righttoleftPhoneTextField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0))
        coordinate.withOffset(CGVector(dx:-40, dy:0)).tap()
        
        // double backspase because first only move to '2' and then remove it
        righttoleftPhoneTextField.typeText("\u{8}")
        righttoleftPhoneTextField.typeText("\u{8}")
        
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, " (098) 765 - 43 - 10")
        
        righttoleftPhoneTextField.typeText("1")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+0 (987) 654 - 31 - 10")
        
    }
    
    func testRightToleftCursorSelectAndMove()
    {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        let righttoleftPhoneTextField = tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element
        
        righttoleftPhoneTextField.tap()
        righttoleftPhoneTextField.typeText("09876543210")
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+0 (987) 654 - 32 - 10")
        
        let coordinate = righttoleftPhoneTextField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0))
        coordinate.withOffset(CGVector(dx:-43, dy:0)).tap()
        
        // double backspase because first only move to '2' and then remove it
        righttoleftPhoneTextField.doubleTap()
        coordinate.withOffset(CGVector(dx:-48, dy:0)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-78, dy:0)))
        righttoleftPhoneTextField.typeText("12345")
        
        XCTAssertEqual(righttoleftPhoneTextField.value as! String, "+0 (987) 123 - 45 - 10")
        
    }
    
}
