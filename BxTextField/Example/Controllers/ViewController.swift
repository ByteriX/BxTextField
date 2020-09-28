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
    @IBOutlet weak var formattedTemplateField: BxTextField!
    
    @IBOutlet weak var webField: BxTextField!
    
    @IBOutlet weak var creditCardField: BxTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightLeftField.formattingDirection = .rightToLeft
        webField.enteredTextColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clickToAdd(UIButton())
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField === creditCardField {
            //creditCardField.shakeX(withOffset: 40, breakFactor: 0.7, duration: 2, maxShakes: 65)
        }
    }
    
    @IBAction func leftRightSwitchChanged(_ sender: Any) {
        leftRightField.isFormattingRewriting = leftRightRewriteSwitch.isOn
    }
    
    @IBAction func rightLeftSwitchChanged(_ sender: Any) {
        rightLeftField.isFormattingRewriting = rightLeftRewriteSwitch.isOn
    }
    
    @IBAction func clickToAdd(_ sender: Any) {
        if creditCardField.enteredText.isEmpty {
            creditCardField.enteredText = "11111111"
        } else {
            creditCardField.enteredText = ""
        }
    }
    
    var formatIndex = 0
    @IBAction func clickChangeFormat(_ sender: Any) {
        let formates = ["(###) ### - ## - ##", "### ### ## ##"]
        formatIndex += 1
        formattedTemplateField.formattingTemplate = formates[formatIndex % formates.count]
    }
    
}

