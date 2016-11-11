import Foundation

class Restroom {
    
    let urinalCount: Int
    
    init(withUrinalCount urinalCount: Int) {
        self.urinalCount = urinalCount
    }
    
    func chooseNextUrinal() -> Int {
        return urinalCount - 1
    }
}
