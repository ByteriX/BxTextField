

Pod::Spec.new do |s|

  s.name         = "BxTextField"
  s.version      = "VERSION_NUMBER"
  s.summary      = "Swift UI component improving features UITextField"
  s.description  = "This component will help iOS developers with different functions of putting text"
  s.homepage     = "https://github.com/ByteriX/BxTextField.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Sergey Balalaev" => "sof.bix@mail.ru" }
  s.platform     = :ios, "8.0"

#s.ios.deployment_target = "5.0"
#s.osx.deployment_target = "10.7"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"

    s.source       = { :git => "https://github.com/ByteriX/BxTextField.git", :tag => s.version} }
#s.frameworks = ["Foundation", "UIKit"]

s.requires_arc     = true
    #s.resources = "BxTextField/Sources/Assets.xcassets", "BxTextField/Sources/**/*.xib"

s.source_files  = "BxTextField/Sources/*.swift"

s.pod_target_xcconfig =  {
'SWIFT_VERSION' => '3.0.1',
'OTHER_SWIFT_FLAGS[config=Debug]' => '-DDEBUG'
}


end
