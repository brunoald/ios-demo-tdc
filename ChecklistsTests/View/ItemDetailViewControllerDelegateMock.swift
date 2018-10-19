@testable import Checklists

class ItemDetailViewControllerDelegateMock: ItemDetailViewControllerDelegate {
    var didCallNewItemAdded = false
    var didCallActionCancelled = false
    var didCallItemEdited = false

    func newItemAdded() {
        didCallNewItemAdded = true
    }

    func actionCancelled() {
        didCallActionCancelled = true
    }

    func itemEdited() {
        didCallItemEdited = true
    }
}
