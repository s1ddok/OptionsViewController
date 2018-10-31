Pod::Spec.new do |s|
  s.name = 'OptionsViewController'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'iOS UIViewController subclass to implement options menu.'
  s.homepage = 'https://github.com/s1ddok/OptionsViewController'
  s.social_media_url = 'https://twitter.com/s1ddok'
  s.authors = { 'Andrey Volodin' => 'siddok@gmail.com' }
  s.source = { :git => 'https://github.com/s1ddok/OptionsViewController.git', :tag => s.version }
  s.ios.deployment_target = '9.0'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source_files = 'OptionsViewController/**/*.swift'
  s.swift_version = '4.2'
  s.resources = ["OptionsViewController/**/*.storyboard", 'OptionsViewController/**/*.xcassets', 'OptionsViewController/**/*.xib']
  s.requires_arc = true
end
