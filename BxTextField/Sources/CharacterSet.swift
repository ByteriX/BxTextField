//
//  CharacterSet.swift
//  BxTextField
//
//  Created by Sergey Balalaev on 05/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

public extension CharacterSet {
    
    public func contains(_ c: Character) -> Bool {
        
        let s = String(c)
        let ix = s.startIndex
        let ix2 = s.endIndex
        let result = s.rangeOfCharacter(from: self, options: [], range: ix..<ix2)
        return result != nil
        
    }
}
