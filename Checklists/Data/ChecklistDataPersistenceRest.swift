import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class ChecklistDataPersistenceRest: ChecklistDataPersistenceDelegate {
    let baseUrl = Environment().host()

    func saveChecklistItems(items: [ChecklistItem]) {
        let parameters: Parameters = [
            "items": items.map({
                [ "text": $0.text, "checked": $0.checked ]
            })
        ]
        _ = Alamofire.request("\(baseUrl)/items.json", method: .post, parameters: parameters).responseData()
    }

    func loadChecklistItems() -> [ChecklistItem] {
        let response = Alamofire.request("\(baseUrl)/items.json").responseJSON()
        let json = JSON(response.result.value)
        let items = json.arrayValue.map({
            ChecklistItem(text: $0["text"].stringValue, checked: $0["checked"].boolValue)
        })
        return items
    }

    func eraseAll() {
    }
}
