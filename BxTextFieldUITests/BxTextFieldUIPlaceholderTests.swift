//
//  BxTextFieldUIPlaceholderTests.swift
//  BxTextFieldUITests
//
//  Created by Sergey Balalaev on 16/05/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import XCTest

class BxTextFieldUIPlaceholderTests: BxUITestCase {
    
    override func setUp()
    {
        super.setUp()
    }
    
    private func getTextField(index: Int) -> XCUIElement {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let textField = tablesQuery.children(matching: .cell).element(boundBy: index).children(matching: .textField).element
        let rewritingSwitch = tablesQuery.children(matching: .cell).element(boundBy: index).children(matching: .switch).element
        
        if let isOn = rewritingSwitch.value as? Bool, isOn {
            rewritingSwitch.tap()
        }
        
        textField.tap()
        textField.typeText("0000000000")
        
        cutMenuAction(textField: textField)
        
        return textField
    }
    
    func testWithoutPattern()
    {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let textField = tablesQuery.children(matching: .cell).element(boundBy: 4).children(matching: .textField).element
        
        XCTAssertEqual(textField.value as! String, "Phone number with +7")
        textField.tap()
        XCTAssertEqual(textField.value as! String, "+7 ")
        textField.typeText("0")
        XCTAssertEqual(textField.value as! String, "+7 (0")
        
        textField.typeText("987654321")
        XCTAssertEqual(textField.value as! String, "+7 (098) 765 - 43 - 21")
        
        cutMenuAction(textField: textField)
        
        XCTAssertEqual(textField.value as! String, "+7 ")
        tablesQuery.children(matching: .cell).element(boundBy: 3).children(matching: .textField).element.tap()
        XCTAssertEqual(textField.value as! String, "Phone number with +7")
    }
        
}
