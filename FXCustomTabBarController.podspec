Pod::Spec.new do |s|
  s.name         = "FXCustomTabBarController"
  s.version      = "0.1"
  s.summary      = "A category of UITabBarController with various custom styles for you to achieve any kinds of the tabBar you like!"
  s.description  = <<-DESC
  					A category of UITabBarController with various custom styles for you to achieve any kinds of the tabBar you like with less work!
                   DESC

  s.homepage     = "https://github.com/ShawnFoo/FXCustomTabBarController"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Shawn Foo" => "fu4904@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/ShawnFoo/FXCustomTabBarController.git", :tag => s.version }
  s.source_files  = "FXCustomTabBarController/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
end
