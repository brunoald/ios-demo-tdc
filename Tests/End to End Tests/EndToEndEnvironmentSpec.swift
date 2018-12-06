import Quick
import Nimble
@testable import Checklists

class EndToEndEnvironmentSpec: QuickSpec {
    override func spec() {
        describe("Environment") {
            context("for integration tests") {
                it("loads host correctly") {
                    let host = Environment().host()
                    expect(host).to(equal("https://ios-tdc-demo-api.herokuapp.com"))
                }
            }
        }
    }
}
