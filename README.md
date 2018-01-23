# BxTextField

This component available put formatted text, for example: phone number, url or email address, credit card with comfortable format. Also you can use other features what we have in `UITextField` whitout issues from Apple.

## Gif demo

![Demo Gif](https://github.com/ByteriX/BxTextField/raw/master/Screenshots/BxTextFieldDemo.gif "Demo Gif")

## Features

- [x] Inherited from `UITextField` and don't use delegate
- [x] Can use patterns sides with constant text
- [x] Have formatting putting with different filling direction
- [x] Correct working with selecting/editing text
- [x] Fixed native issues (problems with edges)
- [x] Covered of Tests

## Requirements

- iOS 8.0+
- Swift 3.0+
- Swift 3.2/4.0 supported

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate BxTextField into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'BxTextField', '~> 1.4'
end
```

Then, run the following command:

```bash
$ pod install
```


### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but BxTextField does support its use on supported platforms. 

Once you have your Swift package set up, adding BxTextField as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .Package(url: "https://github.com/ByteriX/BxTextField.git", majorVersion: 1)
]
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate `BxTextField` into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add `BxTextField` as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/ByteriX/BxTextField.git
```

- Add all sources and resources from local copy of `BxTextField` to the build phase of the project.

- And that's it!


## Usage

### Example

```swift

class SimpleController: UIViewController {
	
	@IBOutlet var urlField: BxTextField!
	@IBOutlet var phoneField: BxTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlField.leftPatternText = "http://"
        urlField.rightPatternText = ".com"
        urlField.addTarget(self, action: #selector(urlDidChange(sender:)), for: .editingChanged)
        
        phoneField.leftPatternText = "+4 "
        phoneField.formattingReplacementChar = "*"
        phoneField.formattingTemplate = "(***) - ** - ** - **"
        phoneField.formattingEnteredCharacters = "0123456789"
        phoneField.addTarget(self, action: #selector(phoneDidChange(sender:)), for: .editingChanged)
    }
    
    @IBAction func urlDidChange (sender: BxTextField) {
        print(sender.enteredText) // it should show "your.inputed.domain.only"
    }
    
    @IBAction func phoneDidChange (sender: BxTextField) {
        print(sender.text) // it should show "+4 (123) - 45 - 67 - 89"
    }
    
}

```

### Different filling direction

```swift

class BxTextFieldFormattingTests: XCTestCase {

    func testRightToLeftDirection() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "#.##"
        textField.formattingDirection = .rightToLeft
        textField.enteredText = "1"
        XCTAssertEqual(textField.text!, "1")
        textField.enteredText = "12"
        XCTAssertEqual(textField.text!, ".12")
        textField.enteredText = "123"
        XCTAssertEqual(textField.text!, "1.23")
    }
    
    func testLeftToRightDirection() {
        let textField = BxTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.formattingTemplate = "#.##"
        textField.formattingDirection = .leftToRight
        textField.enteredText = "1"
        XCTAssertEqual(textField.text!, "1")
        textField.enteredText = "12"
        XCTAssertEqual(textField.text!, "1.2")
        textField.enteredText = "123"
        XCTAssertEqual(textField.text!, "1.23")
    }
}

```

## License

BxTextField is released under the MIT license. See LICENSE for details.
