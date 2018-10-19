@testable import Checklists

class ChecklistDataProviderDelegateMock: ChecklistDataProviderDelegate {
    var didCallGetItems =  false
    var didCallAddItem = false
    var didCallEditItem = false
    var didCallRemoveItem = false
    
    var itemsToReturn: [ChecklistItem]?
    var lastAddedItem: ChecklistItem?
    var lastEditedItem: ChecklistItem?
    var lastRemovedItem: Int?
    
    func getItems() -> [ChecklistItem] {
        didCallGetItems = true
        return itemsToReturn!
    }
    
    func addItem(text: String, checked: Bool) {
        didCallAddItem = true
        lastAddedItem = ChecklistItem(text: text, checked: checked)
    }
    
    func editItem(item: ChecklistItem) {
        didCallEditItem = true
        lastEditedItem = item
    }
    
    func removeItem(index: Int) {
        didCallRemoveItem = true
        lastRemovedItem = index
    }
}
