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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightLeftField.formattingDirection = .rightToLeft
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }


}

