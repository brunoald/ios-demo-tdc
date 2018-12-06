import Quick
import Nimble

class BaseRobot {
    var app: XCUIApplication!
    var testCase: XCTestCase!

    init(_ app: XCUIApplication, testCase: XCTestCase) {
        self.app = app
        self.testCase = testCase
    }

    internal func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 15, file: String = #file, line: Int = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")

        self.testCase.expectation(for: existsPredicate, evaluatedWith: element, handler: nil)

        self.testCase.waitForExpectations(timeout: timeout) { (error) -> Void in
            if error != nil {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.testCase.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
}
