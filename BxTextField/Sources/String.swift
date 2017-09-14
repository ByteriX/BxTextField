/**
 *	@file String.swift
 *	@namespace BxTextField
 *
 *	@details String extension for BxTextField
 *	@date 03.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// String extension for BxTextField
extension String {
    
    /// get NSRange from Range<String.Index> http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index
    public func makeNSRange(from range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
        #if swift(>=3.2)
        if from = from, to = to
        {
        #endif
            let loc = utf16view.startIndex.distance(to: from)
            let len = from.distance(to: to)
            return NSMakeRange(loc, len)
        #if swift(>=3.2)
        }
        return NSRange()
        #endif
    }
    
}
