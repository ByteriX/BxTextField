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

/// For supporting Swift 3/4
#if swift(>=3.2)
    public typealias StringChars = String
#else
    public typealias StringChars = String.CharacterView
#endif

/// String extension for BxTextField
public extension String {
    
#if swift(>=3.2)
    /// For supporting Swift 3/4
    public var chars: String {
        return self
    }
#else
    /// For supporting Swift 3.0
    public var count: Int {
        return characters.count
    }
    
    /// For supporting Swift 3.0
    public func index(_ i: String.Index, offsetBy n: String.IndexDistance) -> String.Index
    {
        return characters.index(i, offsetBy: n)
    }
    
    /// For supporting Swift 3/4
    public var chars: String.CharacterView {
        return characters
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
    
    public func makeRange(from range: NSRange) -> Range<String.Index>? {
#if swift(>=3.2)

        // Prepared test with extrime checking
        guard self.count + 1 > range.location + range.length,
            range.location > -1, range.length > -1
        else {
            return nil
        }
        return Range<String.Index>(range, in: self)
#else
        guard
            let start = index(startIndex, offsetBy: String.IndexDistance(range.location), limitedBy: endIndex),
            let end = index(start, offsetBy: String.IndexDistance(range.length), limitedBy: endIndex)
        else {
            return nil
        }
        return Range<String.Index>.init(uncheckedBounds: (lower: start, upper: end))
#endif
    }
    
}
