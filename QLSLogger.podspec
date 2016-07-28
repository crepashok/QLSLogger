#
# Be sure to run `pod lib lint QLSLogger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'QLSLogger'
    s.version          = '0.1.0'
    s.summary          = 'Tool for displaying logs with different log-levels'
    s.description      = <<-DESC
Great tool for displaying logs with different log-levels, log-module, thread identifier and log-color
                            DESC

    s.homepage         = 'https://github.com/crepashok/QLSLogger'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Pasha' => 'pasha@qlicks.nl' }
    s.source           = { :git => 'https://github.com/crepashok/QLSLogger.git', :tag => s.version.to_s }
    s.ios.deployment_target = '8.0'
    s.source_files = 'QLSLogger/Classes/*'
    s.frameworks = 'UIKit'
    s.dependency 'CocoaLumberjack/Swift', '~> 2.3.0'
    s.dependency 'SwiftHEXColors', '~> 1.0'
end
