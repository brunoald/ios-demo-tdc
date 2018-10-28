//
//  ChecklistsUITests.swift
//  ChecklistsUITests
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Quick
import Nimble
import Swifter

class ChecklistsUITests: QuickSpec {
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
                    .tapOnItem(withText: "Item B")
            }
        }
    }
}
