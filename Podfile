platform :ios, '9.0'

target 'Checklists' do
  use_frameworks!
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Alamofire', '~> 4.7'
  pod 'Alamofire-Synchronous', '~> 4.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'ProgressHUD'

  # Pods for testing
  ['Unit Tests', 'Integration Tests', 'End to End Tests'].each do |target_name|
    target target_name do
      inherit! :search_paths
      pod 'Quick'
      pod 'Nimble'
      pod 'RxBlocking', '~> 4.0'
      pod 'RxTest', '~> 4.0'
      pod 'Swifter', '~> 1.4.5'
    end
  end
end
