
Pod::Spec.new do |s|

  s.name         = "HYWebViewHeader"
  s.version      = "0.0.1"
  s.summary      = "UIWebView with header view."

  s.homepage     = "https://github.com/HyanCat/HYWebViewHeader"

  s.license      = "MIT"
  s.author       = { "HyanCat" => "hyancat@live.cn" }

  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/HyanCat/HYWebViewHeader.git", :tag => "0.0.1" }
  s.source_files = "HYWebViewHeader/*.{h,m}"

  s.frameworks   = "Foundation", "UIKit"

  s.requires_arc = true

end
