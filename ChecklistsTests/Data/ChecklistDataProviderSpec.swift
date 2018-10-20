import Quick
import Nimble
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
            
            context("when adding item") {
                beforeEach {
                    dataProvider.addItem(text: "Item A")
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
                    _ = dataProvider.getItems()
                    
                    item.checked = true
                    dataProvider.editItem(item: item)
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
                    _ = dataProvider.getItems()
                    dataProvider.removeItem(index: 0)
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
