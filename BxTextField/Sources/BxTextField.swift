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

/**
 Custom UITextField with different features
 - Remark: You can use it from storyboard with all InterfaceBuilder featurs with a setting up component

 ```Swift
 let textField = BxTextField(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 40.0))
 textField.leftPatternText = "+7 "
 textField.formattingTemplate = "(###) ### - ## - ##"
 textField.formattingEnteredCharacters = "0123456789"
 // It's all for phone formatting, textField's alrady for using
 ```
 */
open class BxTextField : UITextField {
    
    // MARK: Typies
    
    /// Direction for replacement text from a template
    public enum FormattingDirection {
        /// text will fill from left to right
        case leftToRight
        /// text will fill from right to left
        case rightToLeft
    }
    
    
    // MARK: Static properties
    
    /// default font for pattern text
    public static let standartPatternTextFont = UIFont.boldSystemFont(ofSize: 15)
    /// default font for entered text
    public static let standartEnteredTextFont = UIFont.systemFont(ofSize: 15)
    
    // MARK: Public properties
    
    // MARK: Formatting
    
    /// Format text for putting pattern. If formattingReplacementChar is "*" then example may has value "**** - **** - ********". Default is "". Warning: All symboles how contains in that will be ignored from putting
    @IBInspectable open var formattingTemplate: String = ""
    {
        didSet {
            self.formattingEnteredCharacters = { self.formattingEnteredCharacters }()
        }
    }
    
    /// Replacement symbol, it use for formattingTemplate as is as pattern for replacing. Default is "#"
    @IBInspectable open var formattingReplacementChar: String = "#"
    
    /// Allowable symbols for entering. It used work only if formattingTemplate is not empty, but now if formattingTemplate is empty it same used always. Default is "", that is all symbols.
    @IBInspectable open var formattingEnteredCharacters: String = ""
    {
        didSet {
            if formattingEnteredCharacters.isEmpty {
                if formattingTemplate.isEmpty {
                    formattingEnteredCharSet = CharacterSet()
                } else {
                    formattingEnteredCharSet = CharacterSet(charactersIn: formattingTemplate).inverted
                }
            } else {
                formattingEnteredCharSet = CharacterSet(charactersIn: formattingEnteredCharacters).subtracting(CharacterSet(charactersIn: formattingTemplate))
            }
        }
    }
    /// You can use formattingEnteredCharacters or this from code.
    open var formattingEnteredCharSet: CharacterSet = CharacterSet()
    /// Direction for replacement text from template. Can equal leftToRight or rightToLeft value. Default is leftToRight
    open var formattingDirection: FormattingDirection = .leftToRight
    /// When user would try put extra symboles for filled text and if it's true then text will be rewrited. It depends from formattingDirection too.
    @IBInspectable open var isFormattingRewriting: Bool = false
    
    
    // MARK: Text attributes
    
    /// Editable part of the text, wich can changed by user. **Defaults to "".**
    @IBInspectable open var enteredText: String {
        get {
            guard let text = text else {
                return ""
            }
            var position = 0
            return getEnteredText(with: text, position: &position)
        }
        set {
            text = leftPatternText + newValue + rightPatternText
        }
    }
    /// Not editable pattern part of the text. **Defaults to "".**
    @IBInspectable open var rightPatternText: String = "" {
        willSet {
            guard let text = text, text.isEmpty == false else {
                return
            }
            let enteredText = text[text.startIndex..<text.index(text.endIndex, offsetBy: -self.rightPatternText.count)]
            super.text = enteredText + newValue
        }
        didSet {
            updatePatternText()
        }
    }
    /// Not editable pattern part of the text. **Defaults to "".**
    @IBInspectable open var leftPatternText: String = "" {
        willSet {
            guard let text = text, text.isEmpty == false else {
                return
            }
            let enteredText = text[text.index(text.startIndex, offsetBy: self.leftPatternText.count)..<text.index(text.endIndex, offsetBy: -self.rightPatternText.count)]
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
            if isPlaceholderPatternShown {
                placeholder = leftPatternText + placeholderText + rightPatternText
            } else {
                placeholder = placeholderText
            }
        }
    }
    /// It manages showing of placeholder: with/without patterns.
    @IBInspectable open var isPlaceholderPatternShown: Bool = true {
        didSet {
            updatePatternText()
        }
    }
    /// size with vertical/horizontal edges text showing. Default is zero.
    @IBInspectable open var marginSize = CGSize(width: 0, height: 0)
    {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Useful attributes for text showing
    
    /// Attributes of rightPatternText
#if swift( >=4.0 )
    open var patternTextAttributes: [NSAttributedString.Key: NSObject] {
        return [
            NSAttributedString.Key.font: patternTextFont ?? type(of: self).standartPatternTextFont,
            NSAttributedString.Key.foregroundColor: patternTextColor ?? UIColor.black
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
    open var enteredTextAttributes: [NSAttributedString.Key: NSObject] {
        return [
            NSAttributedString.Key.font: enteredTextFont ?? type(of: self).standartEnteredTextFont,
            NSAttributedString.Key.foregroundColor: enteredTextColor ?? UIColor.black
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
                var attributes: [NSAttributedString.Key: NSObject]? = nil
                if let placeholderColor = placeholderColor {
                    attributes = [
                        NSAttributedString.Key.font: enteredTextFont ?? type(of: self).standartEnteredTextFont,
                        NSAttributedString.Key.foregroundColor: placeholderColor
                    ]
                }
#else
                var attributes: [String: NSObject]? = nil
                if let placeholderColor = placeholderColor {
                    attributes = [
                        NSFontAttributeName: enteredTextFont ?? type(of: self).standartEnteredTextFont,
                        NSForegroundColorAttributeName: placeholderColor
                    ]
                }
#endif
                attributedPlaceholder = getAttributedText(with: placeholder, enteredTextAttributes: attributes)
            }
        }
    }
    /// used from placeholder and placeholderText
    @IBInspectable open var placeholderColor: UIColor?
    
    // MARK: overriding standart properties
    
    /// - Remarks: default is nil. use system font 12 pt as inherited property
    override open var font: UIFont? {
        willSet {
            if let font = newValue {
                enteredTextFont = font
                patternTextFont = font.bold()
            }
        }
    }
    
    /// - Remarks: default is nil. use opaque black as inherited property
    override open var textColor: UIColor? {
        willSet {
            if let textColor = newValue {
                enteredTextColor = textColor
                patternTextColor = textColor
            }
        }
    }
    
    /// - Remarks: default is nil as inherited property
    override open var text: String? {
        didSet {
            updateTextWithPosition()
        }
    }
    
    /**
     Standart borderStyle property
     - Remarks: default is `.none`. If set to `.roundedRect`, custom background images are ignored. It inherited property behavior
     - Warning: Changing of this affects to marginSize an visual showing text in rect.
     */
    override open var borderStyle: UITextField.BorderStyle {
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
