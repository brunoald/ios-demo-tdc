import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class ChecklistDataPersistenceRest: ChecklistDataPersistenceDelegate {
    func saveChecklistItems(items: [ChecklistItem]) {
        let parameters: Parameters = [
            "items": items.map({
                [ "text": $0.text, "checked": $0.checked ]
            })
        ]
        _ = Alamofire.request("http://localhost:3000/items.json", method: .post, parameters: parameters).responseData()
    }
    
    func loadChecklistItems() -> [ChecklistItem] {
        let response = Alamofire.request("http://localhost:3000/items.json").responseJSON()
        let json = JSON(response.result.value)
        return json.arrayValue.map({
            ChecklistItem(text: $0["text"].stringValue, checked: $0["checked"].boolValue)
        })
    }
    
    func eraseAll() {
    }
}
