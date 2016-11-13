import Foundation

class Restroom {
    
    private var urinals: [Urinal]
    var otherDudesAreWaiting: Bool = false
    
    init(withUrinalCount urinalCount: Int) {
        self.urinals = (0..<urinalCount).map { _ in Urinal(occupied: false) }
    }
    
    var bestUrinalChoice: UrinalChoice {
        let maxAdjacentDudeCount = getMaxAdjacentDudeCount()

        var choice: (index: Int, adjacentDudeCount: Int)?
        
        for (index, urinal) in urinals.enumerated().reversed() {
            if urinal.occupied { continue }
            
            let adjacentDudeCount = getAdjacentDudeCount(for: index)
            
            if adjacentDudeCount == 0 {
                choice = (index: index, adjacentDudeCount: 0)
                break
            } else if otherDudesAreWaiting || maxAdjacentDudeCount == adjacentDudeCount {
                guard let previousAdjacentDudeCount = choice?.adjacentDudeCount else {
                    choice = (index: index, adjacentDudeCount: adjacentDudeCount)
                    continue
                }
                if adjacentDudeCount < previousAdjacentDudeCount {
                    choice = (index: index, adjacentDudeCount: adjacentDudeCount)
                }
            }
        }
        
        return choice != nil ? .pee(atUrinal: choice!.index) : .wait
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
    
    private func getMaxAdjacentDudeCount() -> Int {
        return (0..<urinals.count).reduce(0) {
            urinals[$1].occupied ? max($0, getAdjacentDudeCount(for: $1)) : $0
        }
    }
    
    func occupyUrinals(at indexes: Int...) {
        for index in indexes {
            urinals[index].occupied = true
        }
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
