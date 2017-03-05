//
//  BxTextFieldDelegate.swift
//  BxTextField
//
//  Created by Sergey Balalaev on 05/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

/// it will needed probably in a future
class BxTextFieldDelegate: NSObject, UITextFieldDelegate
{
    
    var delegate: UITextFieldDelegate? = nil
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if let delegate = delegate,
            let textFieldShouldBeginEditing = delegate.textFieldShouldBeginEditing
        {
            return textFieldShouldBeginEditing(textField)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if let delegate = delegate,
            let textFieldDidBeginEditing = delegate.textFieldDidBeginEditing
        {
            textFieldDidBeginEditing(textField)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if let delegate = delegate,
            let textFieldShouldEndEditing = delegate.textFieldShouldEndEditing
        {
            return textFieldShouldEndEditing(textField)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        delegate?.textFieldDidEndEditing?(textField)
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason)
    {
        delegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let result = delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)
        {
            if !result {
                return false
            }
        }
        // save changelog
        //
        //
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        if let delegate = delegate,
            let textFieldShouldClear = delegate.textFieldShouldClear
        {
            return textFieldShouldClear(textField)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let delegate = delegate,
            let textFieldShouldReturn = delegate.textFieldShouldReturn
        {
            return textFieldShouldReturn(textField)
        }
        return true
    }
    
}
