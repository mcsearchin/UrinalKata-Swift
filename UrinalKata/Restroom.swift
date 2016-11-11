import Foundation

class Restroom {
    
    var urinalCount: Int
    
    init(withUrinalCount urinalCount: Int) {
        self.urinalCount = urinalCount
    }
    
    var bestUrinalChoice: UrinalChoice {
        return urinalCount > 0 ? .pee(atUrinal: urinalCount - 1) : .wait
    }
    
    func occupyUrinal(at index: Int) {
        urinalCount -= 1
    }
}

enum UrinalChoice: Equatable {
    case pee(atUrinal: Int)
    case wait
}

func ==(first: UrinalChoice, second: UrinalChoice) -> Bool {
    switch (first, second) {
    case (let .pee(firstUrinal), let .pee(secondUrinal)):
        return firstUrinal == secondUrinal
    case (.wait, .wait):
        return true
    default:
        return false
    }
}
