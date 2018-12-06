import Quick
import Nimble
@testable import Checklists

class ChecklistItemSpec: QuickSpec {
    override func spec() {
        describe("ChecklistItem") {
            var item: ChecklistItem!

            beforeEach {
                item = ChecklistItem(text: "Test", checked: true)
            }

            it("sets text value on init") {
                expect(item.text).to(equal("Test"))
            }

            it("sets checked value on init") {
                expect(item.checked).to(beTrue())
            }

            it("can be unchecked") {
                item.toggleChecked()
                expect(item.checked).to(beFalse())
            }
        }
    }
}
