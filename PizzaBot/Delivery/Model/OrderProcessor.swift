//
//  OrderProcessor.swift
//  PizzaBot
//
//  Created by Julio Collado on 10/9/21.
//

import Foundation

protocol Processable {
    func process(order text: String, rule: Rule) throws -> DeliveryOrder
}

struct OrderProcessor: Processable {
    func process(order text: String, rule: Rule) throws -> DeliveryOrder {
        let order = try createOrder(from: text, rule: rule)
        if !isValid(order: order) {
            throw BotInstructionError.invalidPoint
        }
        return order
    }
    
    private func createOrder(from rawOrder: String, rule: Rule) throws -> DeliveryOrder {
        let gridDimensionValues = rawOrder.prefix(rule.gridRule.length).split(separator: rule.gridRule.separator).compactMap { Int($0) }
        guard let xAxis = gridDimensionValues.first, let yAxis = gridDimensionValues.last else {
            throw BotInstructionError.invalidFormat
        }
        let gridDimension = GridDimension(xPoint: xAxis, yPoint: yAxis)
        
        let orders = try rawOrder.dropFirst(rule.deliveryPointRule.length).split(separator: rule.deliveryPointRule.separator).map { rawDeliveryPoint -> GridPoint in
            if let xRawPoint = rawDeliveryPoint[safe: rule.deliveryAxisLocationRule.x],
               let yRawPoint = rawDeliveryPoint[safe: rule.deliveryAxisLocationRule.y],
               let xPoint = xRawPoint.wholeNumberValue,
               let yPoint = yRawPoint.wholeNumberValue {
                return GridPoint(xPoint: xPoint, yPoint: yPoint)
            }
            throw BotInstructionError.invalidFormat
        }
        return PizzaBotDeliveryOrder(gridDimension: gridDimension, deliveryPoints: orders)
    }
    
    private func isValid(order: DeliveryOrder) -> Bool {
        let hasInvalidDeliveryPoint = order.deliveryPoints.contains(where: { deliveryPoint in
            return order.gridDimension.xPoint < deliveryPoint.xPoint || order.gridDimension.yPoint < deliveryPoint.yPoint
        })
        
        return !hasInvalidDeliveryPoint
    }
    
}
