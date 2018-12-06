import Quick
import Nimble

class LocalUITests: QuickSpec {
    override func spec() {
        describe("UI Tests") {
            let apiMock = APIMock()
            var app: XCUIApplication!
            var robot: ChecklistRobot!

            beforeEach {
                apiMock.start()
                app = XCUIApplication()
                app.launchEnvironment = ProcessInfo.processInfo.environment
                app.launch()
                robot = ChecklistRobot(app, testCase: self)
            }

            afterEach {
                apiMock.stop()
            }

            it("performs a user flow") {
                _ = robot
                    .tapOnItem(withText: "Item A")
                    .tapOnDoneButton()
                    .tapOnItem(withText: "Item B")
                    .tapOnDoneButton()
            }
        }
    }
}
