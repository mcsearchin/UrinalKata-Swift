import Foundation

class Restroom {
    
    private var urinals: [Urinal]
    var otherDudesAreWaiting: Bool = false
    
    init(withUrinalCount urinalCount: Int) {
        self.urinals = (0..<urinalCount).map { _ in Urinal(occupied: false) }
    }
    
    var bestUrinalChoice: UrinalChoice {
        var choice: UrinalChoice = .wait
        
        var previousOccupied: Bool
        var nextOccupied: Bool
        for (index, urinal) in urinals.enumerated().reversed() {
            previousOccupied = (index == urinals.count - 1) ? false : urinals[index + 1].occupied
            nextOccupied = index == 0 ? false : urinals[index - 1].occupied
            
            if !urinal.occupied {
                if otherDudesAreWaiting || !previousOccupied && !nextOccupied {
                    choice = .pee(atUrinal: index)
                    break
                }
            }
        }
        
        return choice
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
