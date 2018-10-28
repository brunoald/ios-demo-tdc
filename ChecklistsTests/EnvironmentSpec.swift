import Quick
import Nimble
@testable import Checklists

class EnvironmentSpec: QuickSpec {
    override func spec() {
        describe("Environment") {
            context("for unit tests") {
                it("loads host correctly") {
                    let host = Environment().host()
                    expect(host).to(equal("http://localhost:3000"))
                }
            }
        }
    }
}
