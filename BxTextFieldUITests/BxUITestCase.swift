//
//  BxUITestCase.swift
//  BxTextFieldUITests
//
//  Created by Sergan on 25/01/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import XCTest

class BxUITestCase: XCTestCase {
    
    static var isLaunched: Bool = false
    
    override func setUp() {
        super.setUp()
        
        if type(of: self).isLaunched == false {
            XCUIApplication().launch()
            type(of: self).isLaunched = true
        }
        continueAfterFailure = false
    }

}

extension XCTestCase {
    
    func clearField(_ textField: XCUIElement)
    {
        let app = XCUIApplication()
        textField.tap()
        textField.press(forDuration: 0.5)
        
        let selectAllButton = app.menus.menuItems["Select All"]
        selectAllButton.tap()
        
        let cutButton = app.menus.menuItems["Cut"]
        cutButton.tap()
    }
}
