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
    internal var startPositionText: UITextPosition? {
        get {
            return position(from: endOfDocument, offset: -rightPatternText.characters.count)
        }
    }
    
    internal func goToStartPosition() {
        if let position = startPositionText {
            goTo(textPosition: position)
        }
    }
    
    internal func goTo(textPosition: UITextPosition) {
        selectedTextRange = textRange(from: textPosition, to: textPosition)
    }
    
    /// check selection position, if it has not right position try to change
    internal func checkSelection()
    {
        if let selectedTextRange =  self.selectedTextRange,
            let startPositionText = self.startPositionText
        {
            if self.compare(selectedTextRange.start, to: startPositionText) == .orderedDescending {
                if selectedTextRange.isEmpty {
                    goToStartPosition()
                } else {
                    self.selectedTextRange = textRange(from: beginningOfDocument, to: startPositionText)
                }
            } else if self.compare(selectedTextRange.end, to: startPositionText) == .orderedDescending {
                self.selectedTextRange = textRange(from: selectedTextRange.start, to: startPositionText)
            }
        }
    }
}
