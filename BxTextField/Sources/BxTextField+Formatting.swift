/**
 *	@file BxTextField+Formatting.swift
 *	@namespace BxTextField
 *
 *	@details Public functions for manipulation with a text of BxTextField
 *	@date 05.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Public functions for manipulation with a text of BxTextField
extension BxTextField
{
    
    /// Return clear text without patterns (doesn't include unformatting). The Position needed for shifting cursor
    public func getClearFromPatternText(with text: String, position: inout Int) -> String {
        var result : String = text
        
        // first because it is saffer then left
        if rightPatternText.isEmpty == false,
            text.hasSuffix(rightPatternText)
        {
            let index = result.index(result.endIndex, offsetBy: -rightPatternText.count)
            result = String(result.prefix(upTo: index))
        }
        
        if leftPatternText.isEmpty == false
        {
            if result.hasPrefix(leftPatternText){
                result = String(result.suffix(from: result.index(result.startIndex, offsetBy: leftPatternText.count)))
                position = position - leftPatternText.count
            } else if leftPatternText.count > 1 {
                // bug fixed, but very worst
                let backspaseLeftPatternText = String(leftPatternText.prefix(upTo: leftPatternText.index(before: leftPatternText.endIndex)))
                if result.hasPrefix(backspaseLeftPatternText){
                    result = String(result.suffix(from: result.index(result.startIndex, offsetBy: backspaseLeftPatternText.count)))
                    position = position - backspaseLeftPatternText.count
                }
            }
        }

        if position < 0 {
            position = 0
        }
        
        return result
    }
    
    /// Return clear text without formatting. This algorithm clear all symbols if formattingEnteredCharSet doesn't contain its. The Position needed for shifting cursor
    public func getSimpleUnformattedText(with text: String, position: inout Int) -> String {
        guard formattingTemplate.isEmpty == false, formattingEnteredCharSet.isEmpty == false
        else {
            return text
        }
        var result = ""
        var index = 0
        for char in text.characters {
            if formattingEnteredCharSet.contains(char) {
                result.append(char)
                index = index + 1
            } else {
                if position > index {
                    position = position - 1
                }
            }
        }
        return result
    }
    
    /// Transform text to match with formattingTemplate. The Position needed for shifting cursor
    public func getFormattedText(with text: String, position: inout Int) -> String {
        guard formattingTemplate.isEmpty == false else {
            return text
        }
        
        if text.count > 0 && formattingTemplate.count > 0 {
            
            let characters = text.characters
            let patternes = formattingTemplate.components(separatedBy: String(formattingReplacementChar))
            
            var formattedResult = ""
            
            if formattingDirection == .leftToRight {
                
                formattedResult = formattedResult + getFormattedTextLeftToRight(characters: characters, patternes: patternes, position: &position)
                
            } else if formattingDirection == .rightToLeft {
                
                formattedResult = formattedResult + getFormattedTextRightToLeft(characters: characters, patternes: patternes, position: &position)
                
            }
            
            return formattedResult
        }
        
        return text
    }
    
    /// Transform text to match with formattingTemplate for .leftToRight direction. The Position needed for shifting cursor. This method is unsafety, because have not check input values
    @inline(__always)
    internal func getFormattedTextLeftToRight(characters: String.CharacterView, patternes: [String], position: inout Int) -> String {
        var formattedResult = ""
        
        var index = 0
        let startPosition = position
        
        @inline(__always)
        func checkPosition() {
            if patternes.count > index {
                let patternString = patternes[index]
                formattedResult = formattedResult + patternString
                if startPosition > index {
                    position = position + patternString.count
                }
            }
        }
        
        for character in characters {
            checkPosition()
            formattedResult = formattedResult + String(character)
            index = index + 1
        }
        
        //checkPosition()
        
        if formattingTemplate.count < formattedResult.count {
            formattedResult = String(formattedResult.prefix(upTo: formattingTemplate.endIndex))
        }
        
        return formattedResult
    }
    
    /// Transform text to match with formattingTemplate for .rightToLeft direction. The Position needed for shifting cursor. This method is unsafety, because have not check input values
    @inline(__always)
    internal func getFormattedTextRightToLeft(characters: String.CharacterView, patternes: [String], position: inout Int) -> String
    {
        var formattedResult = ""
        
        var index = 0
        let startPosition = position
        
        @inline(__always)
        func checkPosition() {
            if patternes.count > index {
                let patternString = patternes[patternes.count - index - 1]
                formattedResult = patternString + formattedResult
                if startPosition > characters.count - index {
                    position = position + patternString.count
                }
            }
        }
        
        for character in characters.reversed() {
            checkPosition()
            formattedResult = String(character) + formattedResult
            index = index + 1
        }
        
        checkPosition()
        
        if formattingTemplate.count < formattedResult.count {
            let distance = formattedResult.count - formattingTemplate.count
            formattedResult = String(formattedResult.suffix(from: formattedResult.index(formattedResult.startIndex, offsetBy: distance)))
            position = position - distance
        }
        
        return formattedResult
    }
    
    /// Return clear text without formatting. This algorithm work only by formattingTemplate. If text doesn't match pattern, then it doesn't guarantee expected result.
    @available(iOS, deprecated: 6.0, message: "This method support only .leftToRight direction. Pleace use getSimpleUnformattedText")
    public func getUnformattedText(with text: String) -> String {
        guard formattingTemplate.isEmpty == false else {
            return text
        }
        
        var result = text
        
        if result.characters.count > 0 && formattingTemplate.characters.count > 0 {
            
            let patternes = formattingTemplate.components(separatedBy: String(formattingReplacementChar))
            
            var unformattedResult = ""
            var index = result.startIndex
            for pattern in patternes {
                if pattern.characters.count > 0 {
                    let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: result.endIndex))
                    if let range = result.range(of: pattern, options: .forcedOrdering, range: range, locale: nil)
                    {
                        if index != range.lowerBound {
                            if let endIndex = result.index(range.lowerBound, offsetBy: 0, limitedBy: result.endIndex) {
                                let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: endIndex))
                                unformattedResult = unformattedResult + result.substring(with: range)
                            } else {
                                break
                            }
                        }
                        index = range.upperBound
                    } else
                    {
                        let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: result.endIndex))
                        unformattedResult = unformattedResult + result.substring(with: range)
                        break
                    }
                }
            }
            
            return unformattedResult + rightPatternText
        }
        return text
    }
    
}
