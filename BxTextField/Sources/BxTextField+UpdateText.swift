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
    
//    internal func getReplacePosition(selectedPositon: UITextPosition) -> (range: NSRange, string: String)
//    {
//        let offset = self.offset(from: self.beginningOfDocument, to: selectedPositon)
//        var index = 0
//        while index < offset && beforeChangesText.characters.count < index {
//            if beforeChangesText.r
//        }
//    }
    
    /// update text for showing
    public func updateTextWithPosition() {
        guard let selectedTextRange = selectedTextRange else {
            return
        }
        let selectedPositon = selectedTextRange.start
        guard leftPatternText.isEmpty == false else {
            
            var offset = self.offset(from: self.beginningOfDocument, to: selectedPositon)
            
            let unformatedText = getSimpleUnformatedText(with: text ?? "", position: &offset)
            let formatedText = getFormatedText(with: unformatedText, position: &offset)
            
            updateAttributedText(with: formatedText)
            
            if let position = position(from: self.beginningOfDocument, offset: offset) {
                goTo(textPosition: position)
            } else {
                goTo(textPosition: selectedPositon)
            }
            
            return
        }
        
        var previewText = leftPatternText
        if text == leftPatternText {
            text = "" // for showing placeholder
        } else {
            if text!.hasSuffix(leftPatternText) {
                previewText = text ?? ""
            }
        }
        updateAttributedText(with: previewText)
        goTo(textPosition: selectedPositon)
        beforeChangesText = text!
    }
    
    /// update attributed text with simple text
    public func updateAttributedText(with text: String) {
        if leftPatternText.isEmpty == false,
            let leftPatternTextRange = text.range(of: leftPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil)
        {
            let nsRange = text.makeNSRange(from: leftPatternTextRange)
            
            let attributedString = NSMutableAttributedString(string: text)
            
            attributedString.addAttributes(leftPatternTextAttributes, range: nsRange)
            attributedString.addAttributes(enteredTextAttributes, range: NSMakeRange(0, nsRange.location))
            
            attributedText = attributedString
        } else {
            attributedText = NSMutableAttributedString(string: text)
        }
    }
    
}
