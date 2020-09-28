//
//  MemoryLeaksTests.swift
//  BxTextFieldTests
//
//  Created by Sergey Balalaev on 28.09.2020.
//  Copyright © 2020 Byterix. All rights reserved.
//

import XCTest
@testable import BxTextField
import UIKit

class MemoryLeaksTests: XCTestCase {
    
    class TestViewController: UIViewController
    {
        let textField = BxTextField()
        
        var temp: TestViewController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // for testing memory leak
            //temp = self
            
            self.view.addSubview(textField)
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    func testJustEmpty() {
        assertDeallocation { () -> UIViewController in
            let viewController = TestViewController()
            let _ = viewController.view
            return viewController
        }
    }
    
    func testFormattingTemplate() {
        assertDeallocation { () -> UIViewController in
            let viewController = TestViewController()
            let _ = viewController.view
            viewController.textField.formattingTemplate = "+0 (987) 654 - 32 - 10"
            viewController.textField.formattingTemplate = ""
            viewController.textField.formattingTemplate = "+7 (987) 654 - 32 - 10"
            return viewController
        }
    }
    
    func testFormattingTemplateAndEnteredText() {
        assertDeallocation { () -> UIViewController in
            let viewController = TestViewController()
            let _ = viewController.view
            viewController.textField.formattingTemplate = "+0 (987) 654 - 32 - 10"
            viewController.textField.enteredText = "0123456789"
            viewController.textField.formattingTemplate = ""
            viewController.textField.enteredText = "1111"
            viewController.textField.formattingTemplate = "+7 (987) 654 - 32 - 10"
            viewController.textField.enteredText = "0123456789"
            return viewController
        }
    }
}
