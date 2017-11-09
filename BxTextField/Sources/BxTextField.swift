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
    
    // MARK: Typies
    
    /// Direction for replacement text from template
    public enum FormattingDirection {
        case leftToRight
        case rightToLeft
    }
    
    
    // MARK: Static properties
    
    /// default font for pattern text
    open static let standartPatternTextFont = UIFont.boldSystemFont(ofSize: 15)
    /// default font for entered text
    open static let standartEnteredTextFont = UIFont.systemFont(ofSize: 15)
    
    // MARK: Public properties
    
    // MARK: Formatting
    
    /// Format text for putting pattern. If formattingReplacementChar is "*" then example may has value "**** - **** - ********". Default is ""
    @IBInspectable open var formattingTemplate: String = ""
    /// Replacement symbol, it use for formattingTemplate as is as pattern for replacing. Default is "#"
#if swift( >=4.0 )
    open var formattingReplacementChar: Character = "#"
#else
    @IBInspectable open var formattingReplacementChar: Character = "#"
#endif
    /// Allowable symbols for entering. Uses only if formattingTemplate is not empty. Default is "", that is all symbols.
    @IBInspectable open var formattingEnteredCharacters: String = ""
    {
        didSet {
            if formattingEnteredCharacters.isEmpty {
                formattingEnteredCharSet = CharacterSet().inverted
            } else {
                formattingEnteredCharSet = CharacterSet(charactersIn: formattingEnteredCharacters)
            }
        }
    }
    /// You can use formattingEnteredCharacters or this from code.
    open var formattingEnteredCharSet: CharacterSet = CharacterSet()
    /// Direction for replacement text from template
    open var formattingDirection: FormattingDirection = .leftToRight
    
    
    // MARK: Text attributes
    
    /// Editable part of the text, wich can changed by user. Defaults to "".
    @IBInspectable open var enteredText: String {
        get {
            guard let text = text else {
                return ""
            }
            var position = 0
            return getClearFromPatternText(with: text, position: &position)
        }
        set {
            text = leftPatternText + newValue + rightPatternText
        }
    }
    /// Not editable pattern part of the text. Defaults to "".
    @IBInspectable open var rightPatternText: String = "" {
        willSet {
            guard var text = text, !text.isEmpty else {
                return
            }
            let enteredText = text[text.startIndex..<text.characters.index(text.endIndex, offsetBy: -self.rightPatternText.characters.count)]
            super.text = enteredText + newValue
        }
        didSet {
            updatePatternText()
        }
    }
    /// Not editable pattern part of the text. Defaults to "".
    @IBInspectable open var leftPatternText: String = "" {
        willSet {
            guard var text = text, !text.isEmpty else {
                return
            }
            let enteredText = text[text.characters.index(text.startIndex, offsetBy: self.leftPatternText.characters.count)..<text.characters.index(text.endIndex, offsetBy: -self.rightPatternText.characters.count)]
            super.text = enteredText + newValue
        }
        didSet {
            updatePatternText()
        }
    }
    /// Updating after change of Patterns
    private func updatePatternText() {
        ({self.placeholderText = placeholderText })()
        updateTextWithPosition()
    }
    /// Font of the rightPatternText. Defaults to the bold font.
    @IBInspectable open var patternTextFont: UIFont? {
        didSet {
            ({self.rightPatternText = rightPatternText })()
        }
    }
    /// Color of the rightPatternText. Defaults to the textColor.
    @IBInspectable public var patternTextColor: UIColor? {
        didSet {
            ({self.rightPatternText = rightPatternText })()
        }
    }
    /// Need override standart font, because in iOS 10 changing attributedText rewrite font property
    @IBInspectable open var enteredTextFont: UIFont? {
        didSet {
            ({self.rightPatternText = rightPatternText })()
        }
    }
    /// Color of the rightPatternText. Defaults to the textColor.
    @IBInspectable public var enteredTextColor: UIColor? {
        didSet {
            ({self.rightPatternText = rightPatternText })()
        }
    }
    /// Placeholder without patterns text. Defaults to "".
    @IBInspectable open var placeholderText: String = "" {
        didSet {
            placeholder = leftPatternText + placeholderText + rightPatternText
        }
    }
    ///
    @IBInspectable open var marginSize = CGSize(width: 0, height: 0)
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Useful attributes for text showing
    
    /// Attributes of rightPatternText
#if swift( >=4.0 )
    open var patternTextAttributes: [NSAttributedStringKey: NSObject] {
        return [
            NSAttributedStringKey.font: patternTextFont ?? type(of: self).standartPatternTextFont,
            NSAttributedStringKey.foregroundColor: patternTextColor ?? UIColor.black
        ]
    }
#else
    open var patternTextAttributes: [String: NSObject] {
        return [
            NSFontAttributeName: patternTextFont ?? type(of: self).standartPatternTextFont,
            NSForegroundColorAttributeName: patternTextColor ?? UIColor.black
        ]
    }
#endif
    /// Attributes of enteredText
#if swift( >=4.0 )
    open var enteredTextAttributes: [NSAttributedStringKey: NSObject] {
        return [
            NSAttributedStringKey.font: enteredTextFont ?? type(of: self).standartEnteredTextFont,
            NSAttributedStringKey.foregroundColor: enteredTextColor ?? UIColor.black
        ]
    }
#else
    open var enteredTextAttributes: [String: NSObject] {
        return [
            NSFontAttributeName: enteredTextFont ?? type(of: self).standartEnteredTextFont,
            NSForegroundColorAttributeName: enteredTextColor ?? UIColor.black
        ]
    }
#endif
    
    /// Now it isn't used, because have been complex solution
    override open var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
#if swift( >=4.0 )
                var attributes: [NSAttributedStringKey: NSObject]? = nil
                if let placeholderColor = placeholderColor {
                    attributes = [
                        NSAttributedStringKey.font: enteredTextFont ?? type(of: self).standartEnteredTextFont,
                        NSAttributedStringKey.foregroundColor: placeholderColor
                    ]
                }
                attributedPlaceholder = getAttributedText(with: placeholder, enteredTextAttributes: attributes)
#else
                var attributes: [String: NSObject]? = nil
                if let placeholderColor = placeholderColor {
                    attributes = [
                        NSFontAttributeName: enteredTextFont ?? type(of: self).standartEnteredTextFont,
                        NSForegroundColorAttributeName: placeholderColor
                    ]
                }
                attributedPlaceholder = getAttributedText(with: placeholder, enteredTextAttributes: attributes)
#endif
            }
        }
    }
    ///! used from placeholder and placeholderText
    @IBInspectable open var placeholderColor: UIColor?
    
    override open var font: UIFont? {
        willSet {
            if let font = newValue {
                enteredTextFont = font
                patternTextFont = font.bold()
            }
        }
    }
    
    override open var textColor: UIColor? {
        willSet {
            if let textColor = newValue {
                enteredTextColor = textColor
                patternTextColor = textColor
            }
        }
    }
    
    override open var text: String? {
        didSet {
            updateTextWithPosition()
        }
    }
    
    override open var borderStyle: UITextBorderStyle {
        didSet {
            if borderStyle == .none {
                marginSize = CGSize(width: 0, height: 0)
            } else {
                marginSize = CGSize(width: 8, height: 8)
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
        if patternTextFont == nil {
            if let font = font {
                patternTextFont = font.bold()
            } else {
                patternTextFont = type(of: self).standartPatternTextFont
            }
        }
        if patternTextColor == nil {
            patternTextColor = textColor
        }
        if enteredTextFont == nil {
            if let font = font {
                enteredTextFont = font
            } else {
                enteredTextFont = type(of: self).standartEnteredTextFont
            }
        }
        if enteredTextColor == nil {
            enteredTextColor = textColor
        }
        // creating events
        addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        addTarget(self, action: #selector(textDidBegin(sender:)), for: .editingDidBegin)
        addTarget(self, action: #selector(textDidEnd(sender:)), for: .editingDidEnd)
        // init text
        super.text = ""
    }
    
    // MARK: textField control handler
    
    @objc
    internal func textDidBegin(sender: UITextField) {
        updateTextWithPosition()
    }
    @objc
    internal func textChanged(sender: UITextField)
    {
        updateTextWithPosition()
    }
    @objc
    internal func textDidEnd(sender: UITextField) {
        if enteredText.isEmpty {
            text = ""
        }
    }
    
    // MARK: overrided rects for changing selection
    
    /// need for fix shift when happen beginText
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: marginSize.width, dy: marginSize.height)
    }
    
    /// need for fix shift when happen beginText
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: marginSize.width, dy: marginSize.height)
    }
    
    /// need for change selection position, if it has not right position
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        checkSelection()
        return bounds.insetBy(dx: marginSize.width, dy: marginSize.height)
    }
    
}
