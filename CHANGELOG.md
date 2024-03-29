# Copyright

BxTextField visual component for putting a text

ByteriX, 2017-2018. All right reserved.

# Versions

## 1.12.4 (10.06.2023)
##### Improvements
* support SPM

## 1.12 (08.06.2023)
##### Bug fix
* minimal target to iOS 11

## 1.11 (05.04.2021)
##### Improvements
* added activeLineWidth
* edited updating from changing
* memory leaks tests
* supporting iOS 14

## 1.10.12 (24.04.2020)
##### Improvements
* change description: supporting section
* add Swift 3.2 to supporting

## 1.10.11 (24.04.2020)
##### Bug fix
* edited PodSpec with supporting Swift versions section

## 1.10.10 (11.06.2019)
##### Improvements
* updated build.sh

## 1.10.9 (11.06.2019)
##### Improvements
* swift_versions changed

## 1.10.8 (07.06.2019)
##### Improvements
* rollback to old pods
* fixed build

## 1.10.4 (07.06.2019)
##### Bug fix
* fixed the placeholder shown

## 1.10.3 (05.06.2019)
##### Improvements
* fixed issue with title updating when text was full
* fixed issue with title animation when label was cuted
* added activationDuration as UIAppearance for changing animation

## 1.10.2 (16.05.2019)
##### Bug fix
* fixed a cutting of title text

## 1.10.1 (16.04.2019)
##### Improvements
* added isTitleUpper for the transformation title when it has went from hint state

## 1.10.0 (15.04.2019)
##### Improvements
* added decoration elements: line and title as is as Material designe
* more properties for settings control: title, titleAsHintFont, titleFont, titleSeporatorHeight, lineSeporatorHeight, activeColor, inactiveColor, lineColor, lineWidth
* isActive, isTitleAsHint information properties

## 1.9.0 (29.03.2019)
##### Bug fix
* fixed all warnings
* supporting Swift 5 / iOS 12.2 / XCode 10.2
* fixed unit tests

## 1.8.1 (12.11.2018)
##### Bug fix
* Updating placeholder when have changed placeholderColor

## 1.8.0 (04.10.2018)
##### Improvements
* Supporting Swift 4.2 and iOS 12
* Refactoring older version supporting, but left it

## 1.7.3 (11.09.2018)
##### Improvements
* Documentation with markdown notation
* covarage Unit/UI tests of formattingEnteredCharacters

## 1.7.2 (29.08.2018)
##### Bug fix
* Warning: All symboles how contains in formattingTemplate will be ignored from putting because it had broken alghoritm of putting

## 1.7.1 (13.08.2018)
##### Improvements
* formattingEnteredCharSet can be used if formattingTemplate is empty

## 1.7.0 (16.05.2018)
##### Improvements
* added isPlaceholderPatternShown property for magage pattern showing on placeholder
* test covarage of placeholder changing

## 1.6.2 (07.03.2018)
##### Bug fix
* new public method getEnteredText
* fixed enteredText property when we get unformatted text
* New test for getting nil text

## 1.6.1 (10.02.2018)
##### Bug fix
* bug fixed when changed enteredText from code
* made full general test covarage
* added extrem unit tests
* optimized getFormattedText function

## 1.6.0 (04.02.2018)
##### Improvements
* added isFormattingRewriting property with false default value for limitation formating putting
* added Unit Tests and UI Tests for testing isFormattingRewriting
* changed README

## 1.5.3 (29.01.2018)
##### Improvements
* added UI Test cases with leftToRight direction filing

## 1.5.2 (24.01.2018)
##### Improvements
* added UI Test cases with rightToLeft direction filing

## 1.5.1 (22.01.2018)
##### Improvements
* removed unused delegate class
* added Tests for String and Formatting components
* changed Readme, added example with filling direction

## 1.5.0 (09.01.2018)
##### Improvements
* fixed supporting Swift 3 and compiling/testing on XCode 8.x
* made String extension for supporting Swift 3/4
* added foundation tests
* clean all warnings
* refactoring and small description changes

## 1.4.11 (26.12.2017)
##### Improvements
* added secondary Tests

## 1.4.10 (25.12.2017)
##### Improvements
* added common Tests

## 1.4.9 (25.12.2017)
##### Bug fix
* fixed Tests target

## 1.4.8 (25.12.2017)
##### Improvements
* added Tests

## 1.4.7 (21.12.2017)
##### Improvements
* remade gif url absolutable for Readme

## 1.4.6 (21.12.2017)
##### Improvements
* test build script fix

## 1.4.5 (21.12.2017)
##### Improvements
* test old gif url
* changed build script

## 1.4.4 (14.12.2017)
##### Improvements
* changed common describtion Readme

## 1.4.3 (14.12.2017)
##### Bug fix
* remade gif url absolutable for Readme

## 1.4.2 (14.12.2017)
##### Bug fix
* made gif url absolutable for Readme

## 1.4.1 (08.12.2017)
##### Implement
* changed only description

## 1.4.0 (09.11.2017)
##### Implement
* Supporting Swift 4 with Swift 3
* Change formattingReplacementChar property to String
* Fixed some warnings

## 1.3.4 (19.09.2017)
##### Bug fix
* Fixed showing placeholder from iOS 11

## 1.3.3 (18.09.2017)
##### Bug fix
* Fixed updating placeholder after changing enteredTextColor/enteredTextFont/patternTextFont/patternTextColor

## 1.3.2 (14.09.2017)
##### Implement
* Swift 3.2 with Swift 3.1 supporting

## 1.3.1 (14.09.2017)
##### Implement
* backword Swift 3.1 supporting

## 1.3.0 (12.09.2017)
##### Implement
* Swift 3.2 supporting

## 1.2.5 (02.09.2017)
##### Bug fix
* fixed updating font and text. It was something bug from Apple

## 1.2.4 (22.06.2017)
##### Improvements
* added placeholderColor for a changing color of placeholder

## 1.2.3 (29.05.2017)
##### Improvements
* added formattingDirection for change direction of the putting
* refactored code
* bug with double assign rightPatternText fixed

## 1.1.4 (15.03.2017)
##### Bug fix
* fixed bug with showing the placeholder

## 1.1.3 (14.03.2017)
##### Implementing
* add edge property marginSize for showing border

## 1.1.2 (14.03.2017)
##### Refactoring
* change formated to formatted

## 1.1.1 (14.03.2017)
##### Bug fix
* updating content from properties font, textColor, text
* fixed optional attributes
* corrected logic of content showing

## 1.1.0 (06.03.2017)
##### Implementing
* refactoring: clear formatting function
* descripted all sources
* rename formattingPattern to formattingTemplate
* updated example
* updated readme: GIF, example, features

## 1.0.0 (05.03.2017)
##### Implementing
* added rightPatternText
* changed leftPatternText with rightPatternText
* added formattingPattern
* fixed edges to 8 px

## 0.9.2 (03.03.2017)
##### Implementing
* add leftPatternText with other functions and property

## 0.9.1 (02.03.2017)
##### Bug fix
* change path to sources
* documentation for BxTextField

## 0.9 (02.03.2017)
##### Implementing
* start repository
* clean warnings



# Installation

pod 'BxTextField'
