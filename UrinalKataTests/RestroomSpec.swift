import Quick
import Nimble
@testable import UrinalKata

class RestroomSpec: QuickSpec {
    
    override func spec() {
        var subject: Restroom!

        describe("Restroom") {
            context("with one urinal") {
                beforeEach {
                    subject = Restroom(withUrinalCount: 1)
                }
                
                it("chooses the open urinal") {
                    expect(subject.chooseNextUrinal()).to(equal(0))
                }
            }
        }
    }
}
