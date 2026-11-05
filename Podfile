platform :ios, '15.0'
use_frameworks!

target 'EansdehaobtVaep' do
  pod 'Adjust'
  pod 'Kingfisher'
  pod 'Moya'
  pod 'Toast-Swift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
    end
  end
end
