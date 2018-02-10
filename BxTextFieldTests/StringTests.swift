//
//  StringTests.swift
//  BxTextFieldTests
//
//  Created by Sergan on 26/12/2017.
//  Copyright © 2017 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField

class StringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCreatingRect() {
        let string = "Text with something context"
        let srcRange: NSRange = NSRange(location: 5, length: 9)
        
        guard let dstRange = string.makeRange(from: srcRange) else {
            XCTAssert(false)
            return
        }
        
        let range = string.makeNSRange(from: dstRange)
        XCTAssertEqual(srcRange.location, range.location)
        XCTAssertEqual(srcRange.length, range.length)
    }
    
    func testFailInitRect() {
        let string = "Text"
        let srcRange: NSRange = NSRange(location: 5, length: 9)
        
        XCTAssertNil(string.makeRange(from: srcRange))
    }
    
    func testFailureString() {
        let string = "Text with something context"
        let srcRange: NSRange = NSRange(location: 5, length: 9)
        
        guard let dstRange = string.makeRange(from: srcRange) else {
            XCTAssert(false)
            return
        }
        
        // for failure string all will be the alright anyway
        let failureString = "Fail"
        let range = failureString.makeNSRange(from: dstRange)
        XCTAssertEqual(srcRange.location, range.location)
        XCTAssertEqual(srcRange.length, range.length)
    }
    
    func testCount() {
        let string = "Test String СПЕЦСИМВОЛЫ"
        XCTAssertEqual(string.count, 23)
        
        let emptyString = ""
        XCTAssertEqual(emptyString.count, 0)
        
        let smallString = "Wow"
        XCTAssertNotEqual(smallString.count, 0)
    }
    
    func testIndex() {
        let string = "Test String СПЕЦСИМВОЛЫ"
        let index = string.index(string.startIndex, offsetBy: 5, limitedBy: string.endIndex)
        XCTAssertNotNil(index)
        
        let stopIndex = string.index(index!, offsetBy: 1, limitedBy: string.endIndex)
        XCTAssertNotNil(stopIndex)
        
        let range = Range<String.Index>.init(uncheckedBounds: (lower: index!, upper: stopIndex!))
        
#if swift(>=3.2)
        XCTAssertEqual(string[range], "S")
#else
        XCTAssertEqual(string.substring(with: range), "S")
#endif
    }
    
    func testFailMakeRect() {
        var testRange: NSRange = NSRange(location: 5, length: 9)
        XCTAssertNil("".makeRange(from: testRange))
        
        testRange = NSRange(location: 3, length: 1)
        XCTAssertNil("012".makeRange(from: testRange))
        
        testRange = NSRange(location: 3, length: 0)
        XCTAssertNotNil("012".makeRange(from: testRange))
        
        testRange = NSRange(location: 2, length: 0)
        XCTAssertNil("0".makeRange(from: testRange))
        XCTAssertNotNil("01".makeRange(from: testRange))
        
        testRange = NSRange(location: -1, length: 1)
        XCTAssertNil("123".makeRange(from: testRange))
    }


}
