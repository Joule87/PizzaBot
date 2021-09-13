//
//  BotInstructionError.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

enum BotInstructionError: Error {
    case invalidPoint
    case invalidFormat
    
    var uiDescription: String {
        switch self {
        case .invalidPoint:
            return "Invalid delivery point. Delivery point should fit into the given grid."
        case .invalidFormat:
            return "Invalid instruction format"
        }
    }
}
