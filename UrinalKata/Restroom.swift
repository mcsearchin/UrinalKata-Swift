import Foundation

class Restroom {
    
    var urinals: [Bool]
    
    init(withUrinalCount urinalCount: Int) {
        self.urinals = (0..<urinalCount).map { _ in false }
    }
    
    var bestUrinalChoice: UrinalChoice {
//        for (index, occupied) in urinals.enumerated().reversed() {
//            if !occupied {
//                return .pee(atUrinal: index)
//            }
//        }
        
        return urinals.last! ? .wait : .pee(atUrinal: urinals.count - 1)
    }
    
    func occupyUrinal(at index: Int) {
        urinals[index] = true
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
