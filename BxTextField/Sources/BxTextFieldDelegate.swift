/**
 *	@file BxTextFieldDelegate.swift
 *	@namespace BxTextField
 *
 *	@details Private class not used
 *	@date 05.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Private class not used: it will needed probably in a future
private class BxTextFieldDelegate: NSObject, UITextFieldDelegate
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
