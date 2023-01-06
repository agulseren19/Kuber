# Kuber
# To Run
* sudo gem install cocoapods
* cd Kuber (project's directory)
* pod init
* paste this content to created Podfile:<br>
``` 
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Kuber' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Kuber

  pod 'FirebaseAuth'
  
  pod 'GoogleSignIn'
  
  pod 'FirebaseMessaging'
  
  pod 'Kingfisher', '~> 7.0'

  target 'KuberTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KuberUITests' do
    # Pods for testing
  end

end 
```
* pod install
* open Kuber.xcworkspace in Xcode, wait loading
* build and run in Xcode
