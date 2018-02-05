/**
 *	@file BxTextField+TextPosition.swift
 *	@namespace BxTextField
 *
 *	@details Internal functions for forking with positions in a text of BxTextField
 *	@date 03.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Internal functions for forking with positions in a text of BxTextField
extension BxTextField
{
    
    /// right edges position of the text without patterns
    internal var rightPositionEnteredText: UITextPosition? {
        get {
            return position(from: endOfDocument, offset: -rightPatternText.count)
        }
    }
    
    /// left edges position of the text without patterns
    internal var leftPositionEnteredText: UITextPosition? {
        get {
            return position(from: beginningOfDocument, offset: leftPatternText.count)
        }
    }

    /// Move the cursore to the position
    internal func goTo(textPosition: UITextPosition) {
        selectedTextRange = textRange(from: textPosition, to: textPosition)
    }
    
    /// check selection position, if it has not right position try to change
    internal func checkSelection()
    {
        if let selectedTextRange =  self.selectedTextRange,
            let rightPositionEnteredText = self.rightPositionEnteredText,
            let leftPositionEnteredText = self.leftPositionEnteredText
        {
            if self.compare(selectedTextRange.end, to: leftPositionEnteredText) == .orderedAscending {
                if selectedTextRange.isEmpty {
                    goTo(textPosition: leftPositionEnteredText)
                } else {
                    // it's impossible situation, system's limited
                    self.selectedTextRange = textRange(from: leftPositionEnteredText, to: rightPositionEnteredText)
                }
            } else if self.compare(selectedTextRange.start, to: leftPositionEnteredText) == .orderedAscending {
                self.selectedTextRange = textRange(from: leftPositionEnteredText, to: selectedTextRange.end)
            }
            
            if self.compare(selectedTextRange.start, to: rightPositionEnteredText) == .orderedDescending {
                if selectedTextRange.isEmpty {
                    goTo(textPosition: rightPositionEnteredText)
                } else {
                    // it's impossible situation, system's limited
                    self.selectedTextRange = textRange(from: leftPositionEnteredText, to: rightPositionEnteredText)
                }
            } else if self.compare(selectedTextRange.end, to: rightPositionEnteredText) == .orderedDescending {
                self.selectedTextRange = textRange(from: selectedTextRange.start, to: rightPositionEnteredText)
            }
        }
    }
}
