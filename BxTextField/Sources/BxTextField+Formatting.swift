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
        var result = text
        
        // first because it is saffer then left
        if rightPatternText.isEmpty == false,
            text.hasSuffix(rightPatternText)
        {
            result = result.substring(to: result.index(result.endIndex, offsetBy: -rightPatternText.characters.count))
        }
        
        if leftPatternText.isEmpty == false
        {
            if result.hasPrefix(leftPatternText){
                result = result.substring(from: result.index(result.startIndex, offsetBy: leftPatternText.characters.count))
                position = position - leftPatternText.characters.count
            } else if leftPatternText.characters.count > 1 {
                // bug fixed, but very worst
                let backspaseLeftPatternText = leftPatternText.substring(to: leftPatternText.index(before: leftPatternText.endIndex))
                if result.hasPrefix(backspaseLeftPatternText){
                    result = result.substring(from: result.index(result.startIndex, offsetBy: backspaseLeftPatternText.characters.count))
                    position = position - backspaseLeftPatternText.characters.count
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
        
        if text.characters.count > 0 && formattingTemplate.characters.count > 0 {
            
            let characters = text.characters
            
            let patternes = formattingTemplate.components(separatedBy: String(formattingReplacementChar))
            
            var formattedResult = ""
            var index = 0
            let startPosition = position
            for character in characters {
                if patternes.count > index {
                    let patternString = patternes[index]
                    formattedResult = formattedResult + patternString
                    if startPosition > index {
                        position = position + patternString.characters.count
                    }
                }
                
                formattedResult = formattedResult + String(character)
                index = index + 1
            }
            
            if formattingTemplate.characters.count < formattedResult.characters.count {
                formattedResult = formattedResult.substring(to: formattingTemplate.endIndex)
            }
            
            
            // TODO: I think it is mistake: Please remove rightPatternText from this
            return formattedResult + rightPatternText
        }
        
        return text
    }
    
    /// Return clear text without formatting. This algorithm work only by formattingTemplate. If text doesn't match pattern, then it doesn't guarantee expected result.
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
