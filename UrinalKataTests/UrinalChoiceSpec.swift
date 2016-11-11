import Quick
import Nimble
@testable import UrinalKata

class UrinalChoiceSpec: QuickSpec {
    
    override func spec() {
        describe("UrinalChoice") {
            describe("equality") {

                it("is true when both pee at the same index") {
                    expect(UrinalChoice.pee(atUrinal: 1)).to(equal(UrinalChoice.pee(atUrinal: 1)))
                }
                
                it("is false for different pee indices") {
                    expect(UrinalChoice.pee(atUrinal: 0)).notTo(equal(UrinalChoice.pee(atUrinal: 1)))
                }
                
                it("is true when both are wait") {
                    expect(UrinalChoice.wait).to(equal(UrinalChoice.wait))
                }
                
                it("is false when enums do not match") {
                    expect(UrinalChoice.pee(atUrinal: 0)).notTo(equal(UrinalChoice.wait))
                }
            }
        }
    }
}
