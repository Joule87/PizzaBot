//
//  PizzabotDeliveryOrder.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

protocol DeliveryOrder {
    var gridDimension: GridDimension { get set }
    var deliveryPoints: [GridPoint] { get set }
}

struct PizzaBotDeliveryOrder: DeliveryOrder {
    var gridDimension: GridDimension
    var deliveryPoints: [GridPoint]
}
