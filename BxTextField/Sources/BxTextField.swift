/**
 *	@file BxTextField.swift
 *	@namespace BxTextField
 *
 *	@details Custom UITextField
 *	@date 02.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxTextField.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */


import UIKit

/// Custom UITextField with different features
open class BxTextField : UITextField {
    
    // MARK: Static properties
    
    open static let standartPatternTextFont = UIFont.boldSystemFont(ofSize: 15)
    open static let standartEnteredTextFont = UIFont.systemFont(ofSize: 15)
    
    // MARK: Public properties
    
    /// Editable part of the text, wich can changed by user. Defaults to "".
    @IBInspectable open var enteredText: String {
        get {
            guard let text = text else {
                return ""
            }
            if text.hasSuffix(leftPatternText) {
                return text[text.startIndex..<text.characters.index(text.endIndex, offsetBy: -leftPatternText.characters.count)]
            } else {
                return text
            }
        }
        set {
            text = newValue + leftPatternText
            updateText()
        }
    }
    
    /// Not editable pattern part of the text. Defaults to "".
    @IBInspectable open var leftPatternText: String = "" {
        willSet {
            guard var text = text, !text.isEmpty else {
                return
            }
            let enteredText = text[text.startIndex..<text.characters.index(text.endIndex, offsetBy: -self.leftPatternText.characters.count)]
            self.text = enteredText + newValue
        }
        didSet {
            placeholder = placeholderText + leftPatternText
            updateText()
        }
    }
    
    /// Font of the leftPatternText. Defaults to the bold font.
    @IBInspectable open var leftPatternTextFont: UIFont! {
        didSet {
            ({self.leftPatternText = leftPatternText })()
        }
    }
    
    /// Color of the leftPatternText. Defaults to the textColor.
    @IBInspectable public var leftPatternTextColor: UIColor! {
        didSet {
            ({self.leftPatternText = leftPatternText })()
        }
    }
    
    /// Need override standart font, because in iOS 10 changing attributedText rewrite font property
    @IBInspectable open var enteredTextFont: UIFont! {
        didSet {
            ({self.leftPatternText = leftPatternText })()
        }
    }
    
    /// Attributes of leftPatternText
    open var leftPatternTextAttributes: [String: NSObject] {
        return [
            NSFontAttributeName: leftPatternTextFont,
            NSForegroundColorAttributeName: leftPatternTextColor ?? textColor ?? UIColor.black
        ]
    }
    
    /// Attributes of enteredText
    open var enteredTextAttributes: [String: NSObject] {
        return [
            NSFontAttributeName: enteredTextFont,
            NSForegroundColorAttributeName: textColor ?? UIColor.black
        ]
    }
    
    /// Placeholder without patterns text. Defaults to "".
    @IBInspectable open var placeholderText: String = "" {
        didSet {
            placeholder = placeholderText + leftPatternText
        }
    }
    
    /// Now it isn't used, because have been complex solution
    override open var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                let attributedString = NSMutableAttributedString(string: placeholder)
                let leftPatternTextRange = NSMakeRange(placeholderText.characters.count, leftPatternText.characters.count)
                if placeholder.hasSuffix(leftPatternText) {
                    attributedString.addAttributes(leftPatternTextAttributes, range: leftPatternTextRange)
                    attributedPlaceholder = attributedString
                }
            }
        }
    }
    
    // MARK: Initialization
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initObject()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initObject()
    }
    
    /// initialization this object
    open func initObject() {
        // making text attributes
        if leftPatternTextFont == nil {
            if let font = font {
                leftPatternTextFont = font.bold()
            } else {
                leftPatternTextFont = type(of: self).standartPatternTextFont
            }
        }
        leftPatternTextColor = textColor
        if enteredTextFont == nil {
            if let font = font {
                enteredTextFont = font
            } else {
                enteredTextFont = type(of: self).standartEnteredTextFont
            }
        }
        // creating events
        addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        addTarget(self, action: #selector(textDidBegin(sender:)), for: .editingDidBegin)
        addTarget(self, action: #selector(textDidEnd(sender:)), for: .editingDidEnd)
        // init text
        text = ""
    }
    
    // MARK: text updating methods
    
    /// update text for showing
    public func updateText() {
        guard leftPatternText.isEmpty == false else {
            return
        }
        guard let selectedTextRange = selectedTextRange else {
            return
        }
        let selectedPositon = selectedTextRange.start
        
        var previewText = leftPatternText
        if text == leftPatternText {
            text = "" // for showing placeholder
        } else {
            if text!.hasSuffix(leftPatternText) {
                previewText = text ?? ""
            }
        }
        updateAttributedText(with: previewText)
        goTo(textPosition: selectedPositon)
    }
    
    /// update attributed text with simple text
    public func updateAttributedText(with text: String) {
        if let leftPatternTextRange = text.range(of: leftPatternText, options: NSString.CompareOptions.backwards, range: nil, locale: nil) {
            let nsRange = text.makeNSRange(from: leftPatternTextRange)
            
            let attributedString = NSMutableAttributedString(string: text)
            
            attributedString.addAttributes(leftPatternTextAttributes, range: nsRange)
            attributedString.addAttributes(enteredTextAttributes, range: NSMakeRange(0, nsRange.location))
            
            attributedText = attributedString
        } else {
            attributedText = NSMutableAttributedString(string: text)
        }
    }
    
    // MARK: textField control handler
    
    internal func textDidBegin(sender: UITextField) {
        updateText()
    }
    
    internal func textChanged(sender: UITextField)
    {
        updateText()
    }
    
    internal func textDidEnd(sender: UITextField) {
        if enteredText.isEmpty {
            text = ""
        }
    }
    
    // MARK: overrided rects for changing selection
    
    /// need for fix shift when happen beginText
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 0)
    }
    
    /// need for fix shift when happen beginText
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 0)
    }
    
    /// need for change selection position, if it has not right position
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        checkSelection()
        return bounds.insetBy(dx: 0, dy: 0)
    }
    
}
