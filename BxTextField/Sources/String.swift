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
public extension String {
    
#if swift(>=3.2)
    //
#else
    // For supporting Swift 3.0
    var count: Int {
        return characters.count
    }
    
    func index(_ i: String.Index, offsetBy n: String.IndexDistance) -> String.Index
    {
        return characters.index(i, offsetBy: n)
    }
#endif

    
    /// get NSRange from Range<String.Index> http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index
    public func makeNSRange(from range : Range<String.Index>) -> NSRange {
#if swift(>=4.0)
        return NSRange(range, in: self)
#else
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
        #if swift(>=3.2)
            if let from = from, let to = to
            {
                let loc = utf16view.startIndex.distance(to: from)
                let len = from.distance(to: to)
                return NSMakeRange(loc, len)
            }
            return NSRange()
        #else
            let loc = utf16view.startIndex.distance(to: from)
            let len = from.distance(to: to)
            return NSMakeRange(loc, len)
        #endif
#endif
    }
    
}
