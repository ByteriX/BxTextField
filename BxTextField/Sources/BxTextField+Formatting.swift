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
    
    
#if swift( >=3.2 )
    /**
     Return clear text without left and right patterns
     - Remark: The Position needed for shifting cursor
     - Parameter text: input string
     - Parameter position: output position of cursor
     - Returns: string without left and right patterns from text
     */
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
#else
    public func getClearFromPatternText(with text: String, position: inout Int) -> String {
        var result = text
        
        // first because it is saffer then left
        if rightPatternText.isEmpty == false,
            text.hasSuffix(rightPatternText)
        {
            result = result.substring(to: result.index(result.endIndex, offsetBy: -rightPatternText.count))
        }
        
        if leftPatternText.isEmpty == false
        {
            if result.hasPrefix(leftPatternText){
                result = result.substring(from: result.index(result.startIndex, offsetBy: leftPatternText.count))
                position = position - leftPatternText.count
            } else if leftPatternText.count > 1 {
                // bug fixed, but very worst
                let backspaseLeftPatternText = leftPatternText.substring(to: leftPatternText.index(before: leftPatternText.endIndex))
                if result.hasPrefix(backspaseLeftPatternText){
                    result = result.substring(from: result.index(result.startIndex, offsetBy: backspaseLeftPatternText.count))
                    position = position - backspaseLeftPatternText.count
                }
            }
        }
        
        if position < 0 {
            position = 0
        }
        
        return result
    }
#endif
    
    /// helper for `getSimpleUnformattedText`
    fileprivate func clearExtraSymboles(for text: inout String, position: inout Int) {
        guard formattingTemplate.isEmpty == false, text.isEmpty == false else {
            return
        }
        
        let patternes = formattingTemplate.components(separatedBy: formattingReplacementChar)
        
        let extraSymbolesCount = text.count - patternes.count + 1
        if extraSymbolesCount > 0, position >= extraSymbolesCount,
            let range = text.makeRange(from: NSMakeRange(position - extraSymbolesCount, extraSymbolesCount))
        {
            text.removeSubrange(range)
            position = position - extraSymbolesCount
        }
    }

    /**
        Return clear text without formatting.
        - Remark: This algorithm clear all symbols if formattingEnteredCharSet doesn't contain its. The Position needed for shifting cursor.
        - Parameter text: input string
        - Parameter position: output position of cursor
        - Returns: string without formatting from text
     */
    public func getSimpleUnformattedText(with text: String, position: inout Int) -> String {
        guard formattingEnteredCharSet.isEmpty == false
        else {
            return text
        }
        var result = ""
        var index = 0

        let characters = text.chars
        for char in characters {
            if formattingEnteredCharSet.contains(char) {
                result.append(char)
                index = index + 1
            } else {
                if position > index {
                    position = position - 1
                }
            }
        }
        if isFormattingRewriting == false {
            clearExtraSymboles(for: &result, position: &position)
        }
        return result
    }
    
    /**
     Transform text to match with formattingTemplate.
     - Remark: The Position needed for shifting cursor
     - Parameter text: input string
     - Parameter position: output position of cursor
     - Returns: string with formatting from text from @ref formattingTemplate
     
     ```Swift
     // formattingTemplate = ###-###-##-##
     var position = 5
     let formattedText = getFormattedText(with: "1234567890", position: position)
     // formattedText = 123-456-78-90 position = 6
     ```
     */
    public func getFormattedText(with text: String, position: inout Int) -> String {
        guard formattingTemplate.isEmpty == false else {
            return text
        }
        
        if text.count > 0 && formattingTemplate.count > 0 {

            let characters = text.chars
            let patternes = formattingTemplate.components(separatedBy: formattingReplacementChar)
            
            if formattingDirection == .leftToRight {
                return getFormattedTextLeftToRight(characters: characters, patternes: patternes, position: &position)
            } else if formattingDirection == .rightToLeft {
                return getFormattedTextRightToLeft(characters: characters, patternes: patternes, position: &position)                
            }
            
            return text
        }
        
        return text
    }
    
    /**
     Transform text to match with formattingTemplate for .leftToRight direction.
     - Remark:  The Position needed for shifting cursor. This method is unsafety, because have not check input values
     - Parameter characters: input string with special for (since Swift 4 it will be just String type)
     - Parameter patternes: array of extern symboles from formattingTemplate without replacement symboles
     - Parameter position: output position of cursor
     - Returns: string with formatting from text from **formattingTemplate**
     - SeeAlso: `getFormattedText(with:position:)`, `getFormattedTextRightToLeft(characters:patternes:position:)`
     */
    @inline(__always)
    internal func getFormattedTextLeftToRight(characters: StringChars, patternes: [String], position: inout Int) -> String {
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
#if swift( >=3.2 )
            formattedResult = String(formattedResult.prefix(upTo: formattingTemplate.endIndex))
#else
            formattedResult = formattedResult.substring(to: formattingTemplate.endIndex)
#endif
        }
        
        return formattedResult
    }
    
    /**
     Transform text to match with formattingTemplate for .rightToLeft direction.
     - Remark:  The Position needed for shifting cursor. This method is unsafety, because have not check input values
     - Parameter characters: input string with special for (since Swift 4 it will be just String type)
     - Parameter patternes: array of extern symboles from formattingTemplate without replacement symboles
     - Parameter position: output position of cursor
     - Returns: string with formatting from text from **formattingTemplate**
     - SeeAlso: `getFormattedText(with:position:)`, `getFormattedTextLeftToRight(characters:patternes:position:)`
     */
    @inline(__always)
    internal func getFormattedTextRightToLeft(characters: StringChars, patternes: [String], position: inout Int) -> String
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
#if swift( >=3.2 )
            formattedResult = String(formattedResult.suffix(from: formattedResult.index(formattedResult.startIndex, offsetBy: distance)))
#else
            formattedResult = formattedResult.substring(from: formattedResult.index(formattedResult.startIndex, offsetBy: distance) )
#endif
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
        
        if text.count > 0 && formattingTemplate.count > 0 {
            
            let patternes = formattingTemplate.components(separatedBy: formattingReplacementChar)
            
            var unformattedResult = ""
            var index = text.startIndex
            for pattern in patternes {
                if pattern.count > 0 {
                    let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: text.endIndex))
                    if let range = text.range(of: pattern, options: .forcedOrdering, range: range, locale: nil)
                    {
                        if index != range.lowerBound {
                            if let endIndex = text.index(range.lowerBound, offsetBy: 0, limitedBy: text.endIndex) {
                                let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: endIndex))
                                unformattedResult = unformattedResult + text.substring(with: range)
                            } else {
                                break
                            }
                        }
                        index = range.upperBound
                    } else
                    {
                        let range = Range<String.Index>(uncheckedBounds: (lower: index, upper: text.endIndex))
                        unformattedResult = unformattedResult + text.substring(with: range)
                        break
                    }
                }
            }
            
            return unformattedResult + rightPatternText
        }
        return text
    }
    
}
