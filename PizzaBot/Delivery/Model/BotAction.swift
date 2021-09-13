//
//  CardinalPoint.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

typealias TwoDimensionalAxisPoints = (xPoint: Int, yPoint: Int)
typealias GridPoint = TwoDimensionalAxisPoints
typealias GridDimension = TwoDimensionalAxisPoints

enum BotAction {
    case moveNorth
    case moveEast
    case moveSouth
    case moveWest
    case deliver
    
    var letter: Character {
        switch self {
        case .moveNorth:
            return "N"
        case .moveEast:
            return "E"
        case .moveSouth:
            return "S"
        case .moveWest:
            return "O"
        case .deliver:
            return "D"
        }
    }
}
