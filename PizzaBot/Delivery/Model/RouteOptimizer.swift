//
//  RouteOptimizer.swift
//  PizzaBot
//
//  Created by Julio Collado on 12/9/21.
//

import Foundation

protocol Optimizable {
    func optimize(route deliveryPoints: [GridPoint]) -> [GridPoint]
}

struct RouteOptimizer: Optimizable {
    
    /// Optimize given array of delivery points. It Looks throughout the list for the closer delivery point to the origin, it save it and start looking for a closer one to the last saved point.
    /// - parameter deliveryPoints: list of delivery points
    /// - returns: new optimized list of delivery points
    func optimize(route deliveryPoints: [GridPoint]) -> [GridPoint] {
        var currentPoint = GridPoint(xPoint: 0, yPoint: 0)
        var optimized: [GridPoint] = []
        var deliveryPointsCopy = deliveryPoints
        
        while optimized.count != deliveryPoints.count {
            var stepCounter = 0
            var indexToRemove: Int?
            
            for (index, point) in deliveryPointsCopy.enumerated() {
                let xStepsDiff = abs(point.xPoint - currentPoint.xPoint)
                let yStepsDiff = abs(point.yPoint - currentPoint.yPoint)
                let totalSteps = xStepsDiff + yStepsDiff
                
                let isStandingOnIt = totalSteps == 0
                if  isStandingOnIt {
                    indexToRemove = index
                    break
                }
                
                ///if first cycle takes first delivery point for starting comparisons, so it skip this cycle)
                if index == 0 {
                    stepCounter = totalSteps
                    indexToRemove = index
                    continue
                }
                
                ///if delivery point is at the same distance to the last one saved, skip this cycle and continue looking for a closer one
                if totalSteps == stepCounter {
                    continue
                }
                
                ///if reaching deliveryPoint takes less steps, save deliveryPoint index and update stepCounter with the new closer distance
                if totalSteps < stepCounter {
                    stepCounter = totalSteps
                    indexToRemove = index
                }
            }
            
            if let indexToRemove = indexToRemove {
                let pointToRemove = deliveryPointsCopy[indexToRemove]
                currentPoint = GridPoint(xPoint: pointToRemove.xPoint, yPoint: pointToRemove.yPoint)
                optimized.append(currentPoint)
                deliveryPointsCopy.remove(at: indexToRemove)
            }
        }
        
        return optimized
    }
}
