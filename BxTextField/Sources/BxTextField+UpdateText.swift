/**
 *	@file BxTextField+UpdateText.swift
 *	@namespace BxTextField
 *
 *	@details Functions for drowing final text of BxTextField
 *	@date 05.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Functions for drowing final text of BxTextField
extension BxTextField {
    
    /// Return unformatted text without patterns
    public func getEnteredText(with text: String, position offset: inout Int) -> String {
        let clearText = getClearFromPatternText(with: text, position: &offset)
        let unformattedText = getSimpleUnformattedText(with: clearText, position: &offset)
        return unformattedText
    }
    
    /// update text for showing
    fileprivate func updateTextOnly(offset: inout Int)
    {
        let unformattedText = getEnteredText(with: text ?? "", position: &offset)
        var formattedText = getFormattedText(with: unformattedText, position: &offset)
        
        formattedText = leftPatternText + formattedText + rightPatternText
        
        attributedText = getAttributedText(with: formattedText, enteredTextAttributes: enteredTextAttributes)
        
    }
    
    /**
     Update text for showing
     - Remark: Cursor can move when text lenght is changed
     */
    public func updateTextWithPosition() {
        guard let selectedTextRange = selectedTextRange, isFirstResponder == true else {
            if let text = text, text.isEmpty == false {
                var offset = 0
                updateTextOnly(offset: &offset)
            }
            return
        }
        let selectedPositon = selectedTextRange.start
        var offset = self.offset(from: self.beginningOfDocument, to: selectedPositon)
        
        updateTextOnly(offset: &offset)
        
        if let position = position(from: self.beginningOfDocument, offset: offset + leftPatternText.count) {
            goTo(textPosition: position)
        } else {
            goTo(textPosition: selectedPositon)
        }
    }
    
    ///
#if swift( >=4.0 )
    /**
     Return attributed text for showing prepared text. It can be placehlder/field text and etc.
     - Remark: Attributes need for custom showing content of Field
     - Parameter text: complex text which need add attributes
     - Parameter enteredTextAttributes: attributes for entered symboles only without patterns part.
     - Returns: attributed text for showing prepared text
     */
    open func getAttributedText(with text: String, enteredTextAttributes: [NSAttributedStringKey: NSObject]? = nil) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: text)
        var startEnteredPosition = 0
        var stopEnteredPosition = text.count
        
        if leftPatternText.isEmpty == false,
            let leftPatternTextRange = text.range(of: leftPatternText, options: NSString.CompareOptions.forcedOrdering, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: leftPatternTextRange)
            attributedString.addAttributes(patternTextAttributes, range: nsRange)
            startEnteredPosition = startEnteredPosition + nsRange.location + nsRange.length
        }
        
        if rightPatternText.isEmpty == false,
            let rightPatternTextRange = text.range(of: rightPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: rightPatternTextRange)
            attributedString.addAttributes(patternTextAttributes, range: nsRange)
            stopEnteredPosition = stopEnteredPosition - nsRange.length
        }
        
        if let enteredTextAttributes = enteredTextAttributes {
            attributedString.addAttributes(enteredTextAttributes, range: NSMakeRange(startEnteredPosition, stopEnteredPosition - startEnteredPosition))
        }
        
        return attributedString
    }
#else
    open func getAttributedText(with text: String, enteredTextAttributes: [String: NSObject]? = nil) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: text)
        var startEnteredPosition = 0
        var stopEnteredPosition = text.count
        
        if leftPatternText.isEmpty == false,
            let leftPatternTextRange = text.range(of: leftPatternText, options: NSString.CompareOptions.forcedOrdering, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: leftPatternTextRange)
            attributedString.addAttributes(patternTextAttributes, range: nsRange)
            startEnteredPosition = startEnteredPosition + nsRange.location + nsRange.length
        }
        
        if rightPatternText.isEmpty == false,
            let rightPatternTextRange = text.range(of: rightPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: rightPatternTextRange)
            attributedString.addAttributes(patternTextAttributes, range: nsRange)
            stopEnteredPosition = stopEnteredPosition - nsRange.length
        }
        
        if let enteredTextAttributes = enteredTextAttributes {
            attributedString.addAttributes(enteredTextAttributes, range: NSMakeRange(startEnteredPosition, stopEnteredPosition - startEnteredPosition))
        }
        
        return attributedString
    }
#endif
    
    
}
