/**
 *	@file CharacterSet.swift
 *	@namespace BxTextField
 *
 *	@details CharacterSet extension for BxTextField
 *	@date 05.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// CharacterSet extension for BxTextField
public extension CharacterSet {
    
    /**
     If it contains character symbol then will return true
     - Parameter character: input symbol for searching
     - Returns: true it contains character symbol else false
     */
    public func contains(_ character: Character) -> Bool {
        let string = String(character)
        let ix1 = string.startIndex
        let ix2 = string.endIndex
        let result = string.rangeOfCharacter(from: self, options: [], range: ix1..<ix2)
        return result != nil
    }
}
