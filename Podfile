# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Recipe' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Recipe
    pod 'Firebase'
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'Firebase/Firestore'
    pod 'Firebase/Core'
    pod 'Firebase/Storage'
    pod 'ChameleonFramework'
    pod 'RealmSwift'
    pod 'IQKeyboardManagerSwift'
    
    post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
    end
end
