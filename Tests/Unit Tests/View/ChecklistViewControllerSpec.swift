import Quick
import Nimble

@testable import Checklists

class ChecklistViewControllerSpec: QuickSpec {
    override func spec() {
        var view: ChecklistViewController!
        var dataProvider: ChecklistDataProviderTypeMock!

        beforeEach {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            view = storyboard.instantiateViewController(withIdentifier: "ChecklistViewController") as! ChecklistViewController

            dataProvider = ChecklistDataProviderTypeMock()
            dataProvider.itemsToReturn = []
            view.dataProvider = dataProvider

            view.loadView()
        }

        afterEach {
            view = nil
        }

        describe("viewDidLoad") {
            beforeEach {
                view.viewDidLoad()
            }

            it("calls data provider asking for list of items") {
                expect(dataProvider.didCallGetItems).to(beTrue())
            }
        }

        describe("itemDetail delegate") {
            context("newItemAdded") {
                beforeEach {
                    view.newItemAdded()
                }

                it("calls data provider to reload items") {
                    expect(dataProvider.didCallGetItems).to(beTrue())
                }
            }

            context("itemEdited") {
                beforeEach {
                    view.itemEdited()
                }

                it("calls data provider to reload items") {
                    expect(dataProvider.didCallGetItems).to(beTrue())
                }
            }
        }
    }
}
