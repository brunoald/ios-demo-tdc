autocorrect_files:
	swiftlint autocorrect --format

unit_test:
	bundle exec fastlane unit_test

ui_test:
	bundle exec fastlane ui_test

test_all: unit_test ui_test