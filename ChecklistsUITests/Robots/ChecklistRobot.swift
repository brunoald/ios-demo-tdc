class ChecklistRobot: BaseRobot {
    func tapOnItem(withText: String) -> ChecklistRobot {
        app.tables.staticTexts[withText].tap()
        return self
    }
}
