import Quick
import Nimble
import SwiftMonkey

class MonkeyTest: QuickSpec {
    override func spec() {
        describe("Monkey Tests") {
            let apiMock = APIMock()
            var app: XCUIApplication!
            
            beforeEach {
                apiMock.start()
                app = XCUIApplication()
                app.launchEnvironment = ProcessInfo.processInfo.environment
                app.launch()
            }
            
            afterEach {
                apiMock.stop()
            }
            
            it("performs random clicks and do not crash") {
                let monkey = Monkey(frame: app.frame)
                monkey.addDefaultXCTestPrivateActions()
                monkey.addXCTestTapAlertAction(interval: 100, application: app)
                monkey.monkeyAround(forDuration: 60.0)
            }
        }
    }
}
