//
//  BotTests.swift
//  PizzaBotTests
//
//  Created by Julio Collado on 10/9/21.
//

import XCTest
@testable import PizzaBot

class BotTests: XCTestCase {
    var prototypeBot: PizzaBot!
    var orderProcessor: Processable!
    var routerOptimizer: Optimizable!
    
    override func setUp() {
        routerOptimizer = RouteOptimizer()
        prototypeBot = PizzaBotAlpha(routeOptimizer: routerOptimizer)
        orderProcessor = OrderProcessor()
        
    }
    
    override func tearDown() {
        routerOptimizer = nil
        prototypeBot = nil
        orderProcessor = nil
        
    }
    
    func tests_bot_instruction_succeeded() {
        var validInstruction = "4x3 (2,3) (1,2)"
        var orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        var output = prototypeBot.getInstructions(from: orderProcessed, optimize: false)
        XCTAssertEqual(output, "EENNNDOSD")
        
        validInstruction = "5x5 (0,0) (1,3) (4,4) (4,2) (4,2) (0,1) (3,2) (2,3) (4,1)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: false)
        XCTAssertEqual(output, "DENNNDEEENDSSDDOOOOSDEEENDONDEESSD")
        
        validInstruction = "5x5 (1,3) (4,4)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: false)
        XCTAssertEqual(output, "ENNNDEEEND")
        
        validInstruction = "5x5 (0,0) (0,0)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: false)
        XCTAssertEqual(output, "DD")
        
        validInstruction = "5x3 (0,0) (4,3)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: false)
        XCTAssertEqual(output, "DEEEENNND")
        
        validInstruction = "5x5 (5,5) (4,4)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: false)
        XCTAssertEqual(output, "EEEEENNNNNDOSD")
    }
    
    func tests_bot_delivery_optimized_succeeded() {
        var validInstruction = "4x3 (2,3) (1,2)"
        var orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        var output = prototypeBot.getInstructions(from: orderProcessed, optimize: true)
        XCTAssertEqual(output, "ENNDEND")
        
        validInstruction = "4x4 (2,3) (0,0) (1,2) (0,0)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: true)
        XCTAssertEqual(output, "DDENNDEND")
        
        validInstruction = "4x4 (4,4) (0,0) (1,2) (0,0) (1,2)"
        orderProcessed = try! orderProcessor.process(order: validInstruction, rule: OrderRule.gridPlusDeliveryPoints)
        output = prototypeBot.getInstructions(from: orderProcessed, optimize: true)
        XCTAssertEqual(output, "DDENNDDEEENND")
    }
}
