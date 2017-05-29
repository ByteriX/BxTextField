Pod::Spec.new do |s|

  s.name         = "BxTextField"
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.version      = "1.2.1"
  s.summary      = "This component will help iOS developers with different functions of putting text"
  s.description  = <<-DESC
  					This component will help iOS developers with different functions of putting text. Yap!
                   DESC

  s.homepage          = "https://github.com/MerrickSapsford/Pageboy"
  s.license           = "MIT"
  s.author            = { "Sergey Balalaev" => "sof.bix@mail.ru" }
  s.social_media_url  = "https://github.com/ByteriX/BxTextField"

  s.source       = { :git => "https://github.com/ByteriX/BxTextField.git", :tag => s.version.to_s }
  s.source_files = "BxTextField/Sources/*.{h,m,swift}"

end
