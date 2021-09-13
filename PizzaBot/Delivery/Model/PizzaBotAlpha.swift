//
//  Pizzabot.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

protocol AIRouter {
    var routeOptimizer: Optimizable { get set }
}

protocol PizzaBot {
    func getInstructions(from order: DeliveryOrder, optimize: Bool) -> String
}

class PizzaBotAlpha: PizzaBot, AIRouter {
    var routeOptimizer: Optimizable
    
    init(routeOptimizer: Optimizable) {
        self.routeOptimizer = routeOptimizer
    }
    
    func getInstructions(from order: DeliveryOrder,  optimize: Bool) -> String {
        var result = ""
        var pizzanatorPoint = GridPoint(0,0)
        var deliveryPoints = order.deliveryPoints
        
        if optimize {
            deliveryPoints = routeOptimizer.optimize(route: deliveryPoints)
        }
        
        for nextDeliveryPoint in deliveryPoints {
            let deliveryMoves = getDeliveryMoves(from: pizzanatorPoint, to: nextDeliveryPoint)
            result += deliveryMoves
            pizzanatorPoint = nextDeliveryPoint
        }
        
        return result
    }
    
    private func getDeliveryMoves(from currentGridPoint: GridPoint, to destinationGridPoint: GridPoint) -> String {
        let xValue = destinationGridPoint.xPoint - currentGridPoint.xPoint
        let yValue = destinationGridPoint.yPoint - currentGridPoint.yPoint
        
        let xMoves = getMoves(on: .x, for: xValue)
        let yMoves = getMoves(on: .y, for: yValue)
        
        return xMoves + yMoves + BotAction.deliver.letter.uppercased()
    }
    
    private func getMoves(on axis: Axis, for value: Int) -> String {
        if value == 0 {
            return ""
        }
        var moves: [Character] = []
        switch axis {
        case .x:
            moves = value > 0 ? [Character](repeating: BotAction.moveEast.letter, count: value) : [Character](repeating: BotAction.moveWest.letter, count: abs(value))
        case .y:
            moves = value > 0 ? [Character](repeating: BotAction.moveNorth.letter, count: value) : [Character](repeating: BotAction.moveSouth.letter, count: abs(value))
        }
        return String(moves)
    }
}
