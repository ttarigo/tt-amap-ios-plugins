Pod::Spec.new do |s|
  s.name         = "TTAmapPlugin"
  s.version      = "1.0.0"
  s.summary      = "TTAmapPlugin Source ."
  s.homepage     = 'https://github.com/ttarigo/tt-amap-ios-plugins'
  s.license      = "MIT"
  s.authors      = { "ttarigo" => "lidc227@163.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source = { :git => 'https://github.com/ttarigo/tt-amap-ios-plugins.git', :tag => s.version.to_s }

  s.source_files = "Source/*.{h,m,mm}"
  # s.resources = 'Resources/*'

  s.requires_arc = true
  s.dependency 'AMap3DMap'
  s.dependency 'AMapSearch'
  s.dependency 'AMapLocation'

  s.dependency 'WeexSDK'
  s.dependency 'SDWebImage', '3.7.6'
  s.dependency 'WeexPluginLoader'
end