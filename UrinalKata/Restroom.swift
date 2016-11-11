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
}

func ==(first: UrinalChoice, second: UrinalChoice) -> Bool {
    return true
}
