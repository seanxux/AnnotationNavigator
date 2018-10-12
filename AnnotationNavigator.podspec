Pod::Spec.new do |s|
  s.name           = "AnnotationNavigator"
  s.version        = "0.0.1"
  s.summary        = "AnnotationNavigator for iOS Swift project"
  s.description    = <<-DESC
                    AnnotationNavigator for iOS Swift project
                   DESC
  s.homepage       = "https://github.com/seanxux/AnnotationNavigator"
  s.license        = { :type => "MIT", :file => "LICENSE" }
  s.author         = { "seanxu" => "xiaotengxu@gmail.com" }
  s.source         = { :git => "https://github.com/seanxux/AnnotationNavigator.git", :tag => "#{s.version}" }
  s.source_files   = "Sources/**/*.swift"
  s.resources      = ['Sources/**/*.stencil']
  s.platform = :ios
  s.requires_arc   = true
  s.frameworks     = 'UIKit', 'Foundation'

  s.dependency 'Sourcery',        '~> 0.14.0'
  s.dependency 'URLNavigator',    '~> 2.0.6'

  s.ios.deployment_target    = '8.0'
  s.tvos.deployment_target   = '9.0'
  s.swift_version   = '4.2'
end
