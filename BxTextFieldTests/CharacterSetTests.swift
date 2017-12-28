//
//  CharacterSetTests.swift
//  BxTextFieldTests
//
//  Created by Sergan on 26/12/2017.
//  Copyright © 2017 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField

class CharacterSetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testContains() {
        let string = "This text containt # symbol"
        let charSet = CharacterSet(charactersIn: string)
        XCTAssertTrue(charSet.contains(Character("#")))
        XCTAssertFalse(charSet.contains(Character("%")))
    }
    
    func testAddingContains() {
        var charSet = CharacterSet(charactersIn: "qwerty")
        let char = Character("#")
        XCTAssertFalse(charSet.contains(char))
        charSet.insert("#")
        XCTAssertTrue(charSet.contains(char))
        charSet.remove("#")
        XCTAssertFalse(charSet.contains(char))
    }
    
}
