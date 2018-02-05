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

        XCUIApplication().launch()
        continueAfterFailure = false
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
        let subdomainTextField = tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element

        domainTextField.tap()
        domainTextField.typeText("mail")
        XCTAssertEqual(domainTextField.value as! String, "mail.byterix.com")
        
        cutMenuAction(textField: domainTextField)

        domainTextField.typeText("phone")
        XCTAssertEqual(domainTextField.value as! String, "phone.byterix.com")
        
        subdomainTextField.tap()
        subdomainTextField.typeText("like")
        XCTAssertEqual(subdomainTextField.value as! String, "www.like.byterix.com")
        
        let coordinate = subdomainTextField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0))
        coordinate.withOffset(CGVector(dx:-240, dy:0)).tap()
        
        subdomainTextField.typeText("\u{8}")
        XCTAssertEqual(subdomainTextField.value as! String, "www.like.byterix.com")
        subdomainTextField.typeText("1")
        XCTAssertEqual(subdomainTextField.value as! String, "www.1like.byterix.com")
        subdomainTextField.typeText("\u{8}")
        XCTAssertEqual(subdomainTextField.value as! String, "www.like.byterix.com")
        subdomainTextField.typeText("\u{8}")
        XCTAssertEqual(subdomainTextField.value as! String, "www.like.byterix.com")
        
        coordinate.withOffset(CGVector(dx:-10, dy:0)).tap()
        subdomainTextField.typeText("\u{8}ing")
        XCTAssertEqual(subdomainTextField.value as! String, "www.liking.byterix.com")
        
        subdomainTextField.typeText("\u{8}\u{8}\u{8}\u{8}\u{8}\u{8}\u{8}\u{8}\u{8}\u{8}")
        XCTAssertEqual(subdomainTextField.value as! String, "www..byterix.com")
        subdomainTextField.typeText("123")
        XCTAssertEqual(subdomainTextField.value as! String, "www.123.byterix.com")
    }
    
    func testSelected()
    {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let subdomainTextField = tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element

        subdomainTextField.tap()
        subdomainTextField.typeText("selected")
        XCTAssertEqual(subdomainTextField.value as! String, "www.selected.byterix.com")
        
        let coordinate = subdomainTextField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0.5))
        coordinate.withOffset(CGVector(dx:-10, dy:0.5)).tap()
        
        coordinate.withOffset(CGVector(dx:-100, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-300, dy:0.5)))
         coordinate.withOffset(CGVector(dx:-300, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-20, dy:0)))
        
        subdomainTextField.typeText("1")
        XCTAssertEqual(subdomainTextField.value as! String, "www.selected1.byterix.com")
        
        subdomainTextField.doubleTap()
        coordinate.withOffset(CGVector(dx:-100, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-300, dy:0.5)))
        
        subdomainTextField.typeText("S")
        XCTAssertEqual(subdomainTextField.value as! String, "www.Selected1.byterix.com")
        
        subdomainTextField.doubleTap()
        coordinate.withOffset(CGVector(dx:-200, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-10, dy:0.5)))
        
        subdomainTextField.typeText("\u{8}")
        XCTAssertEqual(subdomainTextField.value as! String, "www.Selected.byterix.com")
        
        subdomainTextField.doubleTap()
        coordinate.withOffset(CGVector(dx:-190, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-10, dy:0.5)))
        coordinate.withOffset(CGVector(dx:-100, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-300, dy:0.5)))
        
        subdomainTextField.typeText("D")
        XCTAssertEqual(subdomainTextField.value as! String, "www.SelecteD.byterix.com")
        
        subdomainTextField.doubleTap()
        coordinate.withOffset(CGVector(dx:-190, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-300, dy:0.5)))
        coordinate.withOffset(CGVector(dx:-100, dy:0.5)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-10, dy:0.5)))
        
        subdomainTextField.typeText("end")
        XCTAssertEqual(subdomainTextField.value as! String, "www.end.byterix.com")
        
        cutMenuAction(textField: subdomainTextField)
        XCTAssertEqual(subdomainTextField.value as! String, "www..byterix.com")
        
    }
    
    
    
}
