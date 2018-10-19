import Quick
import Nimble
@testable import Checklists

class ChecklistDataPersistenceSpec: QuickSpec {
    override func spec() {
        describe("ChecklistDataPersistence") {
            var dataPersistence: ChecklistDataPersistence!
            let itemA = ChecklistItem(text: "Item A", checked: true)
            let itemB = ChecklistItem(text: "Item B", checked: false)
            
            beforeEach {
                dataPersistence = ChecklistDataPersistence()
            }
            
            afterEach {
                dataPersistence.eraseAll()
            }
            
            context("when no items were added") {
                var result: [ChecklistItem]!
                
                beforeEach {
                    result = dataPersistence.loadChecklistItems()
                }
                
                it("returns an empty list") {
                    expect(result).to(beEmpty())
                }
            }

            
            context("when items already exist") {
                var result: [ChecklistItem]!
                
                beforeEach {
                    dataPersistence.saveChecklistItems(items: [itemA, itemB])
                    result = dataPersistence.loadChecklistItems()
                }
                
                it("contains items") {
                    expect(result).toNot(beEmpty())
                }
                
                it("retrieves data previously saved") {
                    expect(result[0].text).to(equal(itemA.text))
                    expect(result[0].checked).to(equal(itemA.checked))
                    
                    expect(result[1].text).to(equal(itemB.text))
                    expect(result[1].checked).to(equal(itemB.checked))
                }
            }
        }
    }
}
