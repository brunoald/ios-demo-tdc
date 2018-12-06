import Quick
import Nimble
import RxBlocking
@testable import Checklists

class ChecklistDataProviderSpec: QuickSpec {
    override func spec() {
        describe("ChecklistDataProvider") {
            var dataProvider: ChecklistDataProvider!
            var dataPersistenceMock: ChecklistDataPersistenceMock!

            beforeEach {
                dataPersistenceMock = ChecklistDataPersistenceMock()
                dataProvider = ChecklistDataProvider(persistence: dataPersistenceMock)
            }

            context("when retrieving items") {
                beforeEach {
                    _ = try! dataProvider.getItems().toBlocking().first()
                }

                it("calls data persistance asking for items") {
                    expect(dataPersistenceMock.didCallLoadChecklistItems).to(beTrue())
                }
            }

            context("when adding item") {
                beforeEach {
                    try! dataProvider.addItem(text: "Item A").toBlocking().first()
                }

                it("tells data persistence delegate to save item") {
                    expect(dataPersistenceMock.didCallSaveChecklistItems).to(beTrue())
                }

                it("sends correct item to persistence delegate") {
                    expect(dataPersistenceMock.lastSavedItems?.count).to(be(1))
                    expect(dataPersistenceMock.lastSavedItems?[0].text).to(equal("Item A"))
                }
            }

            context("when editing an item") {
                let item = ChecklistItem(text: "Item A", checked: false)

                beforeEach {
                    dataPersistenceMock.itemsToReturn = [item]
                    try! dataProvider.getItems().toBlocking().first()

                    item.checked = true
                    try! dataProvider.editItem(item: item).toBlocking().first()
                }

                it("tells data persistence delegate to save edited item") {
                    expect(dataPersistenceMock.didCallSaveChecklistItems).to(beTrue())
                }

                it("sends correct item to persistence delegate") {
                    expect(dataPersistenceMock.lastSavedItems?.count).to(be(1))
                    expect(dataPersistenceMock.lastSavedItems?[0].text).to(equal("Item A"))
                    expect(dataPersistenceMock.lastSavedItems?[0].checked).to(beTrue())
                }
            }

            context("when removing an item") {
                let item = ChecklistItem(text: "Item A", checked: false)

                beforeEach {
                    dataPersistenceMock.itemsToReturn = [item]
                    try! dataProvider.getItems().toBlocking().first()
                    try! dataProvider.removeItem(index: 0).toBlocking().first()
                }

                it("tells data persistence delegate to save edited item") {
                    expect(dataPersistenceMock.didCallSaveChecklistItems).to(beTrue())
                }

                it("sends correct item to persistence delegate") {
                    expect(dataPersistenceMock.lastSavedItems?.count).to(be(0))
                }
            }
        }
    }
}
