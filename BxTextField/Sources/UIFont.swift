/**
 *	@file UIFont.swift
 *	@namespace BxTextField
 *
 *	@details UIFont extension for BxTextField
 *	@date 03.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// UIFont extension for BxTextField
public extension UIFont
{
    
    /// return bold font from current
    /// - Todo: in a future we can change it to property
    public func bold() -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
}
