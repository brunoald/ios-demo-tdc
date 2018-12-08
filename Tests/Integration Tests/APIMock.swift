import Swifter

class APIMock {
    let server = HttpServer()
    var jsonResponse : [[String : Any]] = []

    init() {
        mockItems()
    }
    
    func addItem(id: Int, text: String) {
        let item = [
            "id": id,
            "text": text,
            "checked": false,
            "created_at": "2018-10-28T01:22:25.118Z",
            "updated_at": "2018-10-28T01:22:25.118Z"
            ] as [String : Any]
        
        self.jsonResponse.append(item)
        
        mockItems()
    }
    

    private func mockItems() {
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.ok(.json(self.jsonResponse as AnyObject))
        }
        server.GET["/items.json"] = response
    }

    func start() {
        do {
            try server.start(3000)
        } catch {
            print("Failed to start server")
        }
    }

    func stop() {
        server.stop()
    }
}
