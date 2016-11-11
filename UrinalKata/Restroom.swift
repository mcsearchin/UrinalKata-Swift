import Foundation

class Restroom {
    
    private var urinals: [Urinal]
    var otherDudesAreWaiting: Bool = false
    
    init(withUrinalCount urinalCount: Int) {
        self.urinals = (0..<urinalCount).map { _ in Urinal(occupied: false) }
    }
    
    var bestUrinalChoice: UrinalChoice {
        var choice: UrinalChoice = .wait
        
        for (index, urinal) in urinals.enumerated().reversed() {
            if !urinal.occupied &&
                (index == urinals.count - 1 || !urinals[index + 1].occupied || otherDudesAreWaiting) {
                
                choice = .pee(atUrinal: index)
                break
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
