import Foundation

class Restroom {
    
    let urinalCount: Int
    
    init(withUrinalCount urinalCount: Int) {
        self.urinalCount = urinalCount
    }
    
    var bestChoiceUrinal: Int {
        return urinalCount - 1
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
