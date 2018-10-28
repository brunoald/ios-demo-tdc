import Swifter

class APIMock {
    let server = HttpServer()

    init() {
        mockItems()
    }

    private func mockItems() {
        let jsonResponse = [
            [
                "id": 113,
                "text": "Item A",
                "checked": false,
                "created_at": "2018-10-28T01:22:25.118Z",
                "updated_at": "2018-10-28T01:22:25.118Z",
                "url": "https://ios-tdc-demo-api.herokuapp.com/items/113.json"
            ],
            [
                "id": 114,
                "text": "Item B",
                "checked": true,
                "created_at": "2018-10-28T01:22:25.151Z",
                "updated_at": "2018-10-28T01:22:25.151Z",
                "url": "https://ios-tdc-demo-api.herokuapp.com/items/114.json"
            ]
        ]
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.ok(.json(jsonResponse as AnyObject))
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
