#
# Be sure to run `pod lib lint XMMagnifier.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'XMMagnifier'
    s.version          = '1.0.0'
    s.summary          = '放大镜，可放大屏幕上的内容，最后更新于2023-12-01 18:00:00.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    1.0.0/2023-12-01: 放大镜1.0版本
    DESC
    
    s.homepage         = 'https://github.com/lxumeng/XMMagnifier.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'lxumeng' => '15731206413@163.com' }
    s.source           = { :git => 'https://github.com/lxumeng/XMMagnifier.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '12.0'
    s.platform = :ios, '12.0'
    s.requires_arc = true
    
    # 使用源码方式引入
    puts '-----------------------------------------------------'
    puts s.name + ' 使用源码方式引入'
    puts '-----------------------------------------------------'
    
    s.source_files = 'XMMagnifier/Classes/**/*'
    
    s.pod_target_xcconfig = {
        'DEFINES_MODULE' => 'YES',
    }
    
    # s.resource_bundles = {
    #   'XMMagnifier' => ['XMMagnifier/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
