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
                    expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 0)))
                }
                
                context("when the urinal is occupied") {
                    it("chooses to wait") {
                        subject.occupyUrinal(at: 0)
                        
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.wait))
                    }
                }
            }
            
            context("with two urinals") {
                beforeEach {
                    subject = Restroom(withUrinalCount: 2)
                }
                
                it("chooses the furthest open urinal") {
                    expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 1)))
                }
                
                context("when the furthest urinal is occupied") {
                    it("chooses to wait") {
                        subject.occupyUrinal(at: 1)
                        
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.wait))
                    }
                }
            }
        }
    }
}
