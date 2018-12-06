import Quick
import Nimble

@testable import Checklists

class ItemDetailViewControllerSpec: QuickSpec {
    override func spec() {
        var view: ItemDetailViewController!
        var dataProvider: ChecklistDataProviderTypeMock!
        var delegate: ItemDetailViewControllerDelegateMock!

        beforeEach {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            view = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController

            dataProvider = ChecklistDataProviderTypeMock()
            dataProvider.itemsToReturn = []
            view.dataProvider = dataProvider

            delegate = ItemDetailViewControllerDelegateMock()
            view.delegate = delegate

            view.loadView()
        }

        afterEach {
            view = nil
        }

        describe("viewDidLoad") {
            context("with no item to edit") {
                beforeEach {
                    view.viewDidLoad()
                }

                it("begins with done button disabled") {
                    expect(view.doneBarButton.isEnabled).to(beFalse())
                }
            }

            context("when editing an item") {
                beforeEach {
                    view.itemToEdit = ChecklistItem(text: "item", checked: false)
                    view.viewDidLoad()
                }

                it("begins with done button enabled") {
                    expect(view.doneBarButton.isEnabled).to(beTrue())
                }

                it("begins with text field filled") {
                    expect(view.textField.text).to(equal("item"))
                }
            }
        }

        describe("cancel button") {
            it("calls delegate on tap") {
                view.cancel(UIBarButtonItem())
                expect(delegate.didCallActionCancelled).to(beTrue())
            }
        }

        describe("done button tap") {
            context("when adding an item") {
                beforeEach {
                    view.textField.text = "text"
                    view.done(view)
                }

                it("calls data provider to add item") {
                    expect(dataProvider.didCallAddItem).to(beTrue())
                    expect(dataProvider.lastAddedItem?.text).to(equal("text"))
                }

                it("calls delegate") {
                    expect(delegate.didCallNewItemAdded).toEventually(beTrue())
                }
            }

            context("when editing an item") {
                beforeEach {
                    view.textField.text = "text"
                    view.itemToEdit = ChecklistItem(text: "item", checked: false)
                    view.done(view)
                }

                it("calls data provider to edit item") {
                    expect(dataProvider.didCallEditItem).to(beTrue())
                    expect(dataProvider.lastEditedItem?.text).to(equal("text"))
                }

                it("calls delegate") {
                    expect(delegate.didCallItemEdited).toEventually(beTrue())
                }
            }
        }
    }
}
