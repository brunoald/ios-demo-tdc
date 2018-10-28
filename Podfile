# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Checklists' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Checklists
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Alamofire', '~> 4.7'
  pod 'Alamofire-Synchronous', '~> 4.0'
  pod 'SwiftyJSON', '~> 4.0'

  ['ChecklistsTests', 'ChecklistsUITestLocal', 'ChecklistsUITestIntegration'].each do |target_name|
    target target_name do
      inherit! :search_paths
      # Pods for testing
      pod 'Quick'
      pod 'Nimble'
      pod 'RxBlocking', '~> 4.0'
      pod 'RxTest', '~> 4.0'
      pod 'Swifter', '~> 1.4.5'
    end
  end


  # target 'ChecklistsUITest' do
  #   inherit! :search_paths
  #   # Pods for testing
  #   pod 'Quick'
  #   pod 'Nimble'
  #   pod 'RxBlocking', '~> 4.0'
  #   pod 'RxTest',     '~> 4.0'
  #   pod 'Swifter', '~> 1.4.5'
  # end

end
