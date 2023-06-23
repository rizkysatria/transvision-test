# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'transvision-test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for transvision-test
  pod 'AnyCodable-FlightSchool', '~> 0.2.2'
  pod 'RxSwift', '~> 5.1.3'
  pod 'Alamofire'
  pod 'AnyCodable-FlightSchool', '~> 0.2.2'
  

  target 'transvision-testTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'transvision-testUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["ONLY_ACTIVE_ARCHS"] = "YES"
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
   end
  end
end
