autocorrect_files:
	swiftlint autocorrect --format

unit_test:
	bundle exec fastlane unit_test

ui_test_local:
	bundle exec fastlane ui_test_local

ui_test_integration:
	bundle exec fastlane ui_test_integration

tidy_project:
	xunique -us Checklists.xcodeproj

test_all: unit_test ui_test_local ui_test_integration