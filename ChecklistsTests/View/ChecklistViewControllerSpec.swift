import Quick
import Nimble

@testable import Checklists

class ChecklistViewControllerSpec: QuickSpec {
    override func spec() {
        var view: ChecklistViewController!
        
        beforeEach {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            self.view = storyboard.instantiateViewController(withIdentifier: "ChecklistViewController") as! ChecklistViewController
            
            self.view.loadView()
        }
        
        afterEach {
            self.view = nil
        }
        
        
    }
}
