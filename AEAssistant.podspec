#
# Be sure to run `pod lib lint AEAssistant.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'AEAssistant'
s.version          = '0.0.18.2-beyondsports'
s.summary          = 'A short description of AEAssistant.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
'This is a pod version for AEAssistant.'
DESC

s.homepage         = 'http://gitlab.alisports.com/honggang/AEAssistant.git'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Altair' => 'evendipper@163.com' }
s.source           = { :git => 'https://github.com/AltairEven/AEAssistantPod.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

non_arc_files = 'AEAssistant/Classes/AEAssistant_ToolBox/ToolBox/ALSGTMBase64/*'
s.source_files = 'AEAssistant/Classes/**/*'
s.exclude_files = non_arc_files

s.subspec 'no-arc' do |sp|#一下就是子设置，为需要添加mrc标识的文件进行设置

sp.source_files = non_arc_files

sp.requires_arc = false

end

# s.resource_bundles = {
#   'AEAssistant' => ['AEAssistant/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'

#s.dependency 'AFNetworking', '3.1.0'
s.dependency 'RegexKitLite'#, '4.0'

end
