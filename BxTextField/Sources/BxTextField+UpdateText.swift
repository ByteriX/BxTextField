//
//  BxTextField+UpdateText.swift
//  BxTextField
//
//  Created by Sergey Balalaev on 05/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

/// text updating methods
extension BxTextField {
    
    /// update text for showing
    public func updateTextWithPosition() {
        guard let selectedTextRange = selectedTextRange else {
            return
        }
        let selectedPositon = selectedTextRange.start
        var offset = self.offset(from: self.beginningOfDocument, to: selectedPositon)
        
        let clearText = getClearFromPatternText(with: text ?? "", position: &offset)
        let unformatedText = getSimpleUnformatedText(with: clearText, position: &offset)
        var formatedText = getFormatedText(with: unformatedText, position: &offset)
        
        formatedText = rightPatternText + formatedText + leftPatternText
        
        attributedText = getAttributedText(with: formatedText, enteredTextAttributes: enteredTextAttributes)
        
        if let position = position(from: self.beginningOfDocument, offset: offset + rightPatternText.characters.count) {
            goTo(textPosition: position)
        } else {
            goTo(textPosition: selectedPositon)
        }
    }
    
    /// attributed text for showing
    open func getAttributedText(with text: String, enteredTextAttributes: [String: NSObject]? = nil) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: text)
        var startEnteredPosition = 0
        var stopEnteredPosition = text.characters.count
        
        if rightPatternText.isEmpty == false,
            let rightPatternTextRange = text.range(of: rightPatternText, options: NSString.CompareOptions.forcedOrdering, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: rightPatternTextRange)
            attributedString.addAttributes(patternTextAttributes, range: nsRange)
            startEnteredPosition = startEnteredPosition + nsRange.location + nsRange.length
        }
        
        if leftPatternText.isEmpty == false,
            let leftPatternTextRange = text.range(of: leftPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: leftPatternTextRange)
            attributedString.addAttributes(patternTextAttributes, range: nsRange)
            stopEnteredPosition = stopEnteredPosition - nsRange.length
        }
        
        if let enteredTextAttributes = enteredTextAttributes {
            attributedString.addAttributes(enteredTextAttributes, range: NSMakeRange(startEnteredPosition, stopEnteredPosition - startEnteredPosition))
        }
        
        return attributedString
    }
    
}
