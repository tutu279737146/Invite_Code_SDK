#
# Be sure to run `pod lib lint Invite_Code_SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Invite_Code_SDK'
  s.version          = '0.1.2'
  s.summary          = 'A short description of Invite_Code_SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/tutu279737146/Invite_Code_SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = 'MIT'
  s.author           = { 'tushizhan' => '279737146@qq.com' }
  s.source           = { :git => '/Users/tushizhan/Desktop/Invite_Code_SDK', :tag => '0.1.2' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

s.source_files = 'Invite_Code_SDK/Classes/**/*.{h,m}'

  # s.resource_bundles = {
  #   'Invite_Code_SDK' => ['Invite_Code_SDK/Assets/*.png']
  # }

  s.public_header_files = 'Invite_Code_SDK/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
