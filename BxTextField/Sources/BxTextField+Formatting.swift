//
//  BxTextField+Formatting.swift
//  BxTextField
//
//  Created by Sergey Balalaev on 05/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

extension BxTextField
{
    
    public func getClearFromPatternText(with text: String, position: inout Int) -> String {
        var result = text
        if leftPatternText.isEmpty == false,
            let leftPatternTextRange = text.range(of: leftPatternText, options: NSString.CompareOptions.forcedOrdering, range: nil, locale: nil)
        {
            result = result.substring(from: leftPatternTextRange.upperBound)
            position = position - text.characters.count + result.characters.count
        }
        
        if rightPatternText.isEmpty == false,
            let rightPatternTextRange = result.range(of: rightPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil)
        {
            result = result.substring(to: rightPatternTextRange.lowerBound)
        }
        
        return result
    }
    
    public func getSimpleUnformatedText(with text: String, position: inout Int) -> String {
        guard formattingPattern.isEmpty == false, formattingEnteredCharSet.isEmpty == false
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
    
    public func getFormatedText(with text: String, position: inout Int) -> String {
        guard formattingPattern.isEmpty == false else {
            return text
        }
        
        var result = text
        
        if result.characters.count > 0 && formattingPattern.characters.count > 0 {
            if rightPatternText.isEmpty == false,
                let rightPatternTextRange = result.range(of: rightPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
                result = result.substring(to: rightPatternTextRange.lowerBound)
            }
            
            let patternes = formattingPattern.components(separatedBy: String(formattingReplacementChar))
            
            var formatedResult = ""
            var index = 0
            let startPosition = position
            for character in result.characters {
                if patternes.count > index {
                    let patternString = patternes[index]
                    formatedResult = formatedResult + patternString
                    if startPosition > index {
                        position = position + patternString.characters.count
                    }
                }
                
                formatedResult = formatedResult + String(character)
                index = index + 1
            }
            
            if formattingPattern.characters.count < formatedResult.characters.count {
                formatedResult = formatedResult.substring(to: formattingPattern.endIndex)
            }
            
            return formatedResult + rightPatternText
        }
        
        return text
    }
    
    public func getUnformatedText(with text: String) -> String {
        guard formattingPattern.isEmpty == false else {
            return text
        }
        
        var result = text
        
        if result.characters.count > 0 && formattingPattern.characters.count > 0 {
            if rightPatternText.isEmpty == false,
                let rightPatternTextRange = result.range(of: rightPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
                result = result.substring(to: rightPatternTextRange.lowerBound)
            }
            
            let patternes = formattingPattern.components(separatedBy: String(formattingReplacementChar))
            
            var unformatedResult = ""
            var index = result.startIndex
            for pattern in patternes {
                if pattern.characters.count > 0 {
                    let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: result.endIndex))
                    if let range = result.range(of: pattern, options: .forcedOrdering, range: range, locale: nil)
                    {
                        if index != range.lowerBound {
                            if let endIndex = result.index(range.lowerBound, offsetBy: 0, limitedBy: result.endIndex) {
                                let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: endIndex))
                                unformatedResult = unformatedResult + result.substring(with: range)
                            } else {
                                break
                            }
                        }
                        index = range.upperBound
                    } else
                    {
                        let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: result.endIndex))
                        unformatedResult = unformatedResult + result.substring(with: range)
                        break
                    }
                }
            }
            
            return unformatedResult + rightPatternText
        }
        return text
    }
    
}
