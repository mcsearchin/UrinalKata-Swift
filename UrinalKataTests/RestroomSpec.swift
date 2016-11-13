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
                        subject.occupyUrinals(at: 0)
                        
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
                    beforeEach {
                        subject.occupyUrinals(at: 1)
                    }
                    
                    it("chooses to wait") {
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.wait))
                    }
                    
                    context("and there is a line") {
                        it("chooses the next closest urinal") {
                            subject.otherDudesAreWaiting = true
                            
                            expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 0)))
                        }
                    }
                }
            }
            
            context("with three urinals") {
                beforeEach {
                    subject = Restroom(withUrinalCount: 3)
                }

                context("when the furthest urinal is occupied") {
                    beforeEach {
                        subject.occupyUrinals(at: 2)
                    }
                    
                    it("chooses the closest urinal") {
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 0)))
                    }
                    
                    context("and the next urinal is occupied") {
                        beforeEach {
                            subject.occupyUrinals(at: 1)
                        }
                        
                        it("chooses the closest urinal") {
                            expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 0)))
                        }
                    }
                    
                    context("and the closest urinal is occupied") {
                        beforeEach {
                            subject.occupyUrinals(at: 0)
                        }
                        
                        it("chooses to wait") {
                            expect(subject.bestUrinalChoice).to(equal(UrinalChoice.wait))
                        }
                        
                        context("and there is a line") {
                            it("chooses the middle urinal") {
                                subject.otherDudesAreWaiting = true
                                
                                expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 1)))
                            }
                        }
                    }
                }
                
                context("when the middle urinal is occupied") {
                    beforeEach {
                        subject.occupyUrinals(at: 1)
                    }
                    
                    it("chooses to wait") {
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.wait))
                    }
                    
                    context("and there is a line") {
                        it("chooses the furthest urinal") {
                            subject.otherDudesAreWaiting = true
                            
                            expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 2)))
                        }
                    }
                }
            }
            
            context("with four urinals") {
                beforeEach {
                    subject = Restroom(withUrinalCount: 4)
                }
                
                context("when the fourth and second urinals are occupied and there is a line") {
                    beforeEach {
                        subject.occupyUrinals(at: 3, 1)
                        subject.otherDudesAreWaiting = true
                    }
                    
                    it("chooses the first urinal") {
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 0)))
                    }
                }
            }
            
            context("with six urinals") {
                beforeEach {
                    subject = Restroom(withUrinalCount: 6)
                }
                
                context("when the sixth, fifth, fourth, and second urinals are occupied") {
                    beforeEach {
                        subject.occupyUrinals(at: 5, 4, 3, 1)
                    }
                    
                    it("chooses the third urinal") {
                        expect(subject.bestUrinalChoice).to(equal(UrinalChoice.pee(atUrinal: 2)))
                    }
                }
            }
        }
    }
}
