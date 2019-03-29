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

#if swift(>=3.2)
    /// Chars Set type for searching with supporting Swift 3/4
    public typealias StringChars = String
#else
    public typealias StringChars = String.CharacterView
#endif

/// String extension for BxTextField with supporing Swift 3/4
public extension String {
    
    /// For supporting Swift 3/4
    var chars: StringChars {
#if swift(>=3.2)
        return self
#else
        return characters
#endif
    }
    
#if swift(>=3.2)
#else

    /// The number of elements in the collection.
    ///
    /// To check whether a collection is empty, use its `isEmpty` property
    /// instead of comparing `count` to zero. Unless the collection guarantees
    /// random-access performance, calculating `count` can be an O(*n*)
    /// operation.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the length
    ///   of the collection.
    /// - Warning: Copy-pasted from native component for Swift 3 supporting
    public var count: Int {
        return characters.count
    }
    
    /// Returns an index that is the specified distance from the given index.
    ///
    /// The following example obtains an index advanced four positions from a
    /// string's starting index and then prints the character at that position.
    ///
    ///     let s = "Swift"
    ///     let i = s.index(s.startIndex, offsetBy: 4)
    ///     print(s[i])
    ///     // Prints "t"
    ///
    /// The value passed as `n` must not offset `i` beyond the bounds of the
    /// collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the collection.
    ///   - n: The distance to offset `i`. `n` must not be negative unless the
    ///     collection conforms to the `BidirectionalCollection` protocol.
    /// - Returns: An index offset by `n` from the index `i`. If `n` is positive,
    ///   this is the same value as the result of `n` calls to `index(after:)`.
    ///   If `n` is negative, this is the same value as the result of `-n` calls
    ///   to `index(before:)`.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*n*), where *n* is the absolute
    ///   value of `n`.
    /// - Warning: Copy-pasted from native component for Swift 3 supporting
    public func index(_ i: String.Index, offsetBy n: String.IndexDistance) -> String.Index
    {
        return characters.index(i, offsetBy: n)
    }
#endif
    
    /**
     get NSRange from Range<String.Index>
     - Remark: [Copied from Stackoverflow](http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index)
     - Parameter range: input range for transformation
     - Returns: NSRange object from current Range<String.Index>
     - SeeAlso: `makeRange(from:)`
     
     ```Swift
     let string = "123456789"
     let nsRange = NSRange(location: 3, length: 2)
     let range = string.makeRange(from: nsRange)
     let result = string.makeNSRange(from: range)
     // nsRange == result
     ```
     */
    func makeNSRange(from range : Range<String.Index>) -> NSRange {
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
    
    /**
     get Range<String.Index> from NSRange
     - Parameter range: input range for transformation
     - Returns: Range<String.Index> if is valid NSRange for this string length
     - SeeAlso: `makeNSRange(from:)`
     
     ```Swift
     let string = "123456789"
     let nsRange = NSRange(location: 3, length: 2)
     let range = string.makeRange(from: nsRange)
     // You can use range
     ```
     */
    func makeRange(from range: NSRange) -> Range<String.Index>? {
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
