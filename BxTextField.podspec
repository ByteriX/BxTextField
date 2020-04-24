
#
#  Be sure to run `pod spec lint BxObjC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "BxTextField"
  s.version      = "1.10.11"
  s.summary      = "Swift UI component improving features UITextField"
  s.description  = "This component will help iOS developers with different functions of putting text"
  s.homepage     = "https://github.com/ByteriX/BxTextField.git"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "Sergey Balalaev" => "sof.bix@mail.ru" }
  # Or just: s.author    = "ByteriX"
  # s.authors            = { "ByteriX" => "email@address.com" }
  # s.social_media_url   = "http://twitter.com/ByteriX"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

    s.platform     = :ios, "8.0"
    s.swift_versions = ['4.0', '4.1', '4.2', '5.0', '5.1', '5.2']

#s.ios.deployment_target = "5.0"
#s.osx.deployment_target = "10.7"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"

    s.source       = { :git => "https://github.com/ByteriX/BxTextField.git", :tag => s.version }
    s.frameworks = ["Foundation", "UIKit"]
    #s.resources = "BxTextField/Sources/Assets.xcassets", "BxTextField/Sources/**/*.xib"

    s.source_files  = "BxTextField/Sources/**/*.{swift}", "BxTextField/Sources/*.{swift}"

#s.test_spec 'Tests' do |test_spec|
#test_spec.platform     = :ios, "11.0"
#    test_spec.source_files = "BxTextFieldTests/*.swift"
    #, "BxTextFieldUITests/*.swift"
#    test_spec.framework = 'XCTest'
#end



  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #



end
