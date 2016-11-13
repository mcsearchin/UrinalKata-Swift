import Foundation

class Restroom {
    
    private var urinals: [Urinal]
    var otherDudesAreWaiting: Bool = false
    
    init(withUrinalCount urinalCount: Int) {
        self.urinals = (0..<urinalCount).map { _ in Urinal(occupied: false) }
    }
    
    var bestUrinalChoice: UrinalChoice {
        var choiceIndex: Int?
        var adjacentDudeCount: Int?
        
        for (index, urinal) in urinals.enumerated().reversed() {
            if !urinal.occupied {
                let currentAdjacentDudeCount = getAdjacentDudeCount(for: index)
                
                if currentAdjacentDudeCount == 0 {
                    choiceIndex = index
                    break
                } else if otherDudesAreWaiting {
                    if let previousAdjacentDudeCount = adjacentDudeCount {
                        if currentAdjacentDudeCount < previousAdjacentDudeCount {
                            adjacentDudeCount = currentAdjacentDudeCount
                            choiceIndex = index
                        }
                    } else {
                        adjacentDudeCount = currentAdjacentDudeCount
                        choiceIndex = index
                    }
                }
            }
        }
        
        return choiceIndex != nil ? .pee(atUrinal: choiceIndex!) : .wait
    }
    
    private func getAdjacentDudeCount(for index: Int) -> Int {
        var adjacentDudeCount = 2
        if index == urinals.count - 1 || !urinals[index + 1].occupied {
            adjacentDudeCount -= 1
        }
        if index == 0 || !urinals[index - 1].occupied {
            adjacentDudeCount -= 1
        }
        
        return adjacentDudeCount
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
