autocorrect_files:
	swiftlint autocorrect --format

unit_tests:
	bundle exec fastlane unit_tests

integration_tests:
	bundle exec fastlane integration_tests

end_to_end_tests:
	bundle exec fastlane end_to_end_tests

tidy_project:
	xunique -us Checklists.xcodeproj

test_all: unit_tests integration_tests end_to_end_tests