class ChecklistRobot: BaseRobot {
    func tapOnItem(withText: String) -> ChecklistRobot {
        let element = app.tables.buttons["More Info, \(withText)"]
        waitForElementToAppear(element: element)
        element.tap()
        return self
    }

    func tapOnAddItem() -> ChecklistRobot {
        app.navigationBars["Checklists"].buttons["Add"].tap()
        return self
    }

    func typeText(_ text: String) -> ChecklistRobot {
        app.typeText(text)
        return self
    }

    func tapOnDoneButton() -> ChecklistRobot {
        app.buttons["Done"].firstMatch.tap()
        return self
    }

    func eraseText() -> ChecklistRobot {
        app.keys["delete"].press(forDuration: 5.0)
        return self
    }
}
