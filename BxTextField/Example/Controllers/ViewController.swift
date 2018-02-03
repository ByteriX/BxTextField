//
//  ViewController.swift
//  BxTextField
//
//  Created by Sergey Balalaev on 02/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var rightLeftField: BxTextField!
    @IBOutlet weak var rightLeftRewriteSwitch: UISwitch!
    @IBOutlet weak var leftRightField: BxTextField!
    @IBOutlet weak var leftRightRewriteSwitch: UISwitch!
    
    @IBOutlet weak var webField: BxTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightLeftField.formattingDirection = .rightToLeft
        webField.enteredTextColor = UIColor.red
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func leftRightSwitchChanged(_ sender: Any) {
        leftRightField.isFormattingRewriting = leftRightRewriteSwitch.isOn
    }
    
    @IBAction func rightLeftSwitchChanged(_ sender: Any) {
        rightLeftField.isFormattingRewriting = rightLeftRewriteSwitch.isOn
    }
    
}

