@testable import Checklists
import RxSwift

class ChecklistDataProviderDelegateMock: ChecklistDataProviderType {
    var didCallGetItems =  false
    var didCallAddItem = false
    var didCallEditItem = false
    var didCallRemoveItem = false

    var itemsToReturn: [ChecklistItem]?
    var lastAddedItem: ChecklistItem?
    var lastEditedItem: ChecklistItem?
    var lastRemovedItem: Int?

    func getItems() -> Observable<[ChecklistItem]> {
        didCallGetItems = true
        return Observable.just(itemsToReturn!)
    }

    func addItem(text: String, checked: Bool) -> Observable<Void> {
        didCallAddItem = true
        lastAddedItem = ChecklistItem(text: text, checked: checked)
        return Observable.empty()
    }

    func editItem(item: ChecklistItem) -> Observable<Void> {
        didCallEditItem = true
        lastEditedItem = item
        return Observable.empty()
    }

    func removeItem(index: Int) -> Observable<Void> {
        didCallRemoveItem = true
        lastRemovedItem = index
        return Observable.empty()
    }
}
