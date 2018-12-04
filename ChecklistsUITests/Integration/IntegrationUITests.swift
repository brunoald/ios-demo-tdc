//
//  ChecklistsUITests.swift
//  ChecklistsUITests
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Quick
import Nimble

class IntegrationUITests: QuickSpec {
    override func spec() {
        describe("UI Tests") {
            var app: XCUIApplication!
            var robot: ChecklistRobot!

            beforeEach {
                app = XCUIApplication()
                app.launchEnvironment = ProcessInfo.processInfo.environment
                app.launch()
                robot = ChecklistRobot(app, testCase: self)
            }

            it("performs a user flow") {
                let uniqueId = Int(NSDate().timeIntervalSince1970)
                let newItemName = "New Item \(uniqueId)"
                let editedItemName = "Edited Item \(uniqueId)"

                _ = robot
                    .tapOnAddItem()
                    .typeText(newItemName)
                    .tapOnDoneButton()
                    .tapOnItem(withText: newItemName)
                    .eraseText()
                    .typeText(editedItemName)
                    .tapOnDoneButton()
                    .tapOnItem(withText: editedItemName)
            }
        }
    }
}
