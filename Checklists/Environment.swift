import Foundation

class Environment {
    let environment = ProcessInfo.processInfo.environment["ENVIRONMENT"]!

    let configuration = [
        "Local": [
            "Host": "http://localhost:3000"
        ],
        "Integration": [
            "Host": "https://ios-tdc-demo-api.herokuapp.com"
        ]
    ]

    func host() -> String {
        return configuration[environment]!["Host"]!
    }
}
