Pod::Spec.new do |s|
  s.name         = 'PWAds'
  s.version      = '3.6.3'
  s.summary      = "The Phunware Advertising SDK for iOS"
  s.homepage     = "http://phunware.github.io/maas-ads-ios-sdk/"
  s.author       = { 'Phunware, Inc.' => 'http://www.phunware.com' }
  s.social_media_url = 'https://twitter.com/Phunware'

  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/phunware/maas-ads-ios-sdk.git", :tag => '3.6.3' }
  s.license      = { :type => 'Copyright', :text => 'Copyright 2017 by Phunware Inc. All rights reserved.' }

  s.public_header_files = 'Framework/PWAdvertising.framework/Versions/A/Headers/*.h'
  s.ios.vendored_frameworks = 'Framework/PWAdvertising.framework'
  s.resource  = 'Framework/PWAds.bundle'
  s.source_files = 'Framework/**/*.{h,m}'
  s.dependency 'PWCore', '3.1.1'

  s.xcconfig      = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/PWAds/**"'}
  s.ios.frameworks = 'Security', 'QuartzCore', 'SystemConfiguration', 'MobileCoreServices', 'CoreTelephony', 'MessageUI', 'EventKit', 'EventKitUI', 'CoreMedia', 'AVFoundation', 'MediaPlayer', 'AudioToolbox', 'AdSupport', 'StoreKit', 'WebKit'
  s.library        = 'sqlite3', 'z'
  s.requires_arc = true
end
