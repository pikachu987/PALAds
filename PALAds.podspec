#
# Be sure to run `pod lib lint PALAds.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PALAds'
  s.version          = '0.1.7'
  s.summary          = 'PALAds'
  s.description      = <<-DESC
My Lib PALAds
                       DESC
  s.homepage         = 'https://github.com/pikachu987/PALAds'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pikachu987' => 'pikachu77769@gmail.com' }
  s.source           = { :git => 'https://github.com/pikachu987/PALAds.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'PALAds/Classes/**/*'
  s.swift_version = '5.0'
  s.static_framework = true
  s.dependency 'Google-Mobile-Ads-SDK', '8.3.0'
end
