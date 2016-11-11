import Foundation

class Restroom {
    
    private var urinals: [Urinal]
    var lineToPee: Bool = false
    
    init(withUrinalCount urinalCount: Int) {
        self.urinals = (0..<urinalCount).map { _ in Urinal(occupied: false) }
    }
    
    var bestUrinalChoice: UrinalChoice {
        if urinals.last!.occupied {
            return lineToPee ? .pee(atUrinal: 0) : .wait
        } else {
            return .pee(atUrinal: urinals.count - 1)
        }
    }
    
    func occupyUrinal(at index: Int) {
        urinals[index].occupied = true
    }    
}

struct Urinal {
    var occupied: Bool
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
