//
//  UIFontTests.swift
//  BxTextFieldTests
//
//  Created by Sergan on 26/12/2017.
//  Copyright © 2017 Byterix. All rights reserved.
//

import XCTest

class UIFontTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreating() {
        let srcFont = UIFont.systemFont(ofSize: 12)
        XCTAssertNotEqual(srcFont.fontName, srcFont.bold().fontName)
    }
    
    func testCompare() {
        let srcFont = UIFont.systemFont(ofSize: 12)
        let dstFont = UIFont.boldSystemFont(ofSize: 12)
        XCTAssertEqual(dstFont.fontName, srcFont.bold().fontName)
        XCTAssertEqual(dstFont.xHeight, srcFont.bold().xHeight)
        XCTAssertEqual(dstFont.pointSize, srcFont.bold().pointSize)
        
    }
    
}
