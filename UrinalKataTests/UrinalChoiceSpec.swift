import Quick
import Nimble
@testable import UrinalKata

class UrinalChoiceSpec: QuickSpec {
    
    override func spec() {
        describe("UrinalChoice") {
            describe("equality") {
                var firstChoice: UrinalChoice!
                var secondChoice: UrinalChoice!
                
                context("when both have the same index") {
                    it("are equal") {
                        firstChoice = .pee(atUrinal: 1)
                        secondChoice = .pee(atUrinal: 2)
                        
                        expect(firstChoice).to(equal(secondChoice))
                    }
                    
                }
            }
        }
    }
}
