//
//  OrderTests.swift
//  OrderTests
//
//  Created by Julio Collado on 10/9/21.
//

import XCTest
@testable import PizzaBot

class OrderTests: XCTestCase {
    
    var orderProcessor: Processable!
    
    override func setUp() {
        orderProcessor = OrderProcessor()
    }
    
    override func tearDown() {
        orderProcessor = nil
    }
    
    func test_valid_order() {
        let validInstruction = "4x3 (2,3) (1,2)"
        let orderProcessed = try? orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        
        XCTAssertEqual(orderProcessed?.gridDimension.xPoint, 4)
        XCTAssertEqual(orderProcessed?.gridDimension.yPoint, 3)
        XCTAssertEqual(orderProcessed?.deliveryPoints.first?.xPoint, 2)
        XCTAssertEqual(orderProcessed?.deliveryPoints.first?.yPoint, 3)
        XCTAssertEqual(orderProcessed?.deliveryPoints.last?.xPoint, 1)
        XCTAssertEqual(orderProcessed?.deliveryPoints.last?.yPoint, 2)
        XCTAssertEqual(orderProcessed?.deliveryPoints.count, 2)
    }
    
    private func checkInstruction(_ invalidInstruction: String, for instructionError: BotInstructionError) {
        do {
            let _ = try orderProcessor.process(order: invalidInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        } catch {
            let botInstructionError = error as! BotInstructionError
            XCTAssertEqual(botInstructionError, instructionError)
        }
    }
    
    func test_invalid_order() {
        //MARK: - Case1
        var invalidInstruction = "3x3 (2,3) (6,2)"
        checkInstruction(invalidInstruction, for: .invalidPoint)
        
        //MARK: - Case2
        invalidInstruction = "3x3 (2,3) (1,,2)"
        checkInstruction(invalidInstruction, for: .invalidFormat)
        
        //MARK: - Case3
        invalidInstruction = "33 (2,3) (6,2)"
        checkInstruction(invalidInstruction, for: .invalidFormat)
        
        //MARK: - Case4
        invalidInstruction = "33 () (6,2)"
        checkInstruction(invalidInstruction, for: .invalidFormat)
        
        //MARK: - Case5
        invalidInstruction = "3x3 (2,2)(1,2)"
        checkInstruction(invalidInstruction, for: .invalidFormat)
    }
    
}
