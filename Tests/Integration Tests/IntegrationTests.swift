import Quick
import Nimble

class IntegrationTests: QuickSpec {
    override func spec() {
        describe("Integration Tests") {
            var apiMock: APIMock!
            var app: XCUIApplication!
            var robot: ChecklistRobot!

            beforeEach {
                apiMock = APIMock()
                apiMock.start()
                apiMock.addItem(id: 1, text: "Item A")
                apiMock.addItem(id: 2, text: "Item B")
                
                app = XCUIApplication()
                app.launchEnvironment = ProcessInfo.processInfo.environment
                app.launch()
                robot = ChecklistRobot(app, testCase: self)
            }

            afterEach {
                apiMock.stop()
            }
            
            it("shows list of items") {
                _ = robot
                    .tapOnItem(withText: "Item A")
                    .tapOnDoneButton()
                    .tapOnItem(withText: "Item B")
                    .tapOnDoneButton()
            }
            
            it("shows a form to add item") {
                _ = robot
                    .tapOnAddItem()
                    .tapOnDoneButton()
            }
        }
    }
}
