@testable import Checklists

class ChecklistDataPersistenceMock: ChecklistDataPersistenceDelegate {
    var didCallSaveChecklistItems = false
    var didCallLoadChecklistItems = false
    var didCallEraseAll = false
    
    var itemsToReturn: [ChecklistItem] = []
    var lastSavedItems: [ChecklistItem]?
    
    func saveChecklistItems(items: [ChecklistItem]) {
        didCallSaveChecklistItems = true
        lastSavedItems = items
    }
    
    func loadChecklistItems() -> [ChecklistItem] {
        didCallLoadChecklistItems = true
        return itemsToReturn
    }
    
    func eraseAll() {
        didCallEraseAll = true
    }
}
