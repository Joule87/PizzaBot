//
//  OrderRule.swift
//  PizzaBot
//
//  Created by Julio Collado on 13/9/21.
//

import Foundation

protocol Rule {
    var regex: String { get }
    var gridRule: (length: Int, separator: Character) { get }
    var deliveryPointRule: (length: Int, separator: Character) { get }
    var deliveryAxisLocationRule: (x: Int, y: Int) { get }
}

enum OrderRule: Rule {
    case gridPlusDeliveryPoints
    
    var regex: String {
        switch self {
        case .gridPlusDeliveryPoints:
            return Regex.gridPlusDeliveryPoints
        }
    }
    
    var gridRule: (length: Int, separator: Character) {
        switch self {
        case .gridPlusDeliveryPoints:
            return (3,"x")
        }
    }
    
    var deliveryPointRule: (length: Int, separator: Character) {
        switch self {
        case .gridPlusDeliveryPoints:
            return (3," ")
        }
    }
    
    var deliveryAxisLocationRule: (x: Int, y: Int) {
        switch self {
        case .gridPlusDeliveryPoints:
            return (1, 3)
        }
    }
    
}
