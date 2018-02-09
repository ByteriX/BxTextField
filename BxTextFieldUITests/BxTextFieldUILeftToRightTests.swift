//
//  BxTextFieldUILeftToRightTests.swift
//  BxTextFieldUITests
//
//  Created by Sergan on 25/01/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import XCTest

class BxTextFieldUILeftToRightTests: BxUITestCase {
    
    var textField : XCUIElement!
    var rewritingSwitch : XCUIElement!
    
    override func setUp()
    {
        super.setUp()
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        textField = tablesQuery.children(matching: .cell).element(boundBy: 2).children(matching: .textField).element
        rewritingSwitch = tablesQuery.children(matching: .cell).element(boundBy: 2).children(matching: .switch).element
        
        textField.tap()
        textField.typeText("0000000000")
        
        cutMenuAction(textField: textField)
    }
    
    func testSpendNumber()
    {
        textField.typeText("0")
        XCTAssertEqual(textField.value as! String, "+0")
        
        textField.typeText("9")
        XCTAssertEqual(textField.value as! String, "+0 (9")
        
        textField.typeText("87")
        XCTAssertEqual(textField.value as! String, "+0 (987")
        
        textField.typeText("6")
        XCTAssertEqual(textField.value as! String, "+0 (987) 6")
        
        textField.typeText("5")
        XCTAssertEqual(textField.value as! String, "+0 (987) 65")
        textField.typeText("432")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32")
        
        textField.typeText("5")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 5")
        
        textField.typeText("1")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 51")
        
        // select only last symboles, because space symbole is seporator
        textField.doubleTap()
        textField.typeText("3334444")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 33")
        
    }
    
    func testCursorSelect()
    {
        textField.typeText("09876543210")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        textField.doubleTap()
        
        // It is better solution
        let coordinate = textField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0.5))
        coordinate.withOffset(CGVector(dx:-20, dy:0)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-300, dy:0)))
        
        textField.typeText("567890")
        
        XCTAssertEqual(textField.value as! String, "+5 (678) 90")
        
        textField.typeText("4321")
        XCTAssertEqual(textField.value as! String, "+5 (678) 904 - 32 - 1")
        textField.typeText("0")
        XCTAssertEqual(textField.value as! String, "+5 (678) 904 - 32 - 10")
        textField.typeText("9")
        XCTAssertEqual(textField.value as! String, "+5 (678) 904 - 32 - 10")
        
    }
    
    func testCursorMove()
    {
        textField.typeText("09876543210")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        let coordinate = textField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0))
        coordinate.withOffset(CGVector(dx:-40, dy:0)).tap()
        
        // double backspase because first only move to '2' and then remove it
        textField.typeText("\u{8}")
        textField.typeText("\u{8}")
        
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 31 - 0")
        
        textField.typeText("4")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 34 - 10")
        
    }
    
    func testCursorSelectAndMove()
    {
        textField.typeText("09876543210")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        let coordinate = textField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0))
        coordinate.withOffset(CGVector(dx:-43, dy:0)).tap()
        textField.doubleTap()
        coordinate.withOffset(CGVector(dx:-48, dy:0)).press(forDuration: 1, thenDragTo: coordinate.withOffset(CGVector(dx:-78, dy:0)))
        
        textField.typeText("123")
        XCTAssertEqual(textField.value as! String, "+0 (987) 123 - 10")
        
        textField.typeText("45")
        XCTAssertEqual(textField.value as! String, "+0 (987) 123 - 45 - 10")
        
    }
    
    func testRewriting()
    {
        textField.typeText("09876543210")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        let coordinate = textField.coordinate(withNormalizedOffset: CGVector(dx:1, dy:0))
        coordinate.withOffset(CGVector(dx:-40, dy:0)).tap()
        
        textField.typeText("123")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        textField.typeText("\u{8}\u{8}")
        rewritingSwitch.tap()
        textField.typeText("12345")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 12 - 34")
        
        rewritingSwitch.tap()
        coordinate.withOffset(CGVector(dx:-40, dy:0)).tap()
        textField.typeText("987")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 12 - 34")
        textField.typeText("\u{8}\u{8}")
        textField.typeText("987")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 98 - 34")
    }
    
    func testEnteredCharacters()
    {
        textField.typeText("xxxxx09876543210")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        cutMenuAction(textField: textField)
        
        textField.typeText("09876543210xxxxx")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
        
        cutMenuAction(textField: textField)
        
        textField.typeText("xx0xxx987xxx6x5x4x32xxx10xx")
        XCTAssertEqual(textField.value as! String, "+0 (987) 654 - 32 - 10")
    }
    
    
}
