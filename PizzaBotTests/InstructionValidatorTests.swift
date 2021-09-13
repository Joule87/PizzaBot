//
//  InstructionValidatorTests.swift
//  PizzaBotTests
//
//  Created by Julio Collado on 13/9/21.
//

import XCTest
@testable import PizzaBot

class InstructionValidatorTests: XCTestCase {
    
    var validator: InstructionValidator!
    let regex = OrderRule.gridPlusDeliveryPoints.regex

    override func setUp() {
        validator = InstructionValidator()
    }

    override func tearDown() {
        validator = nil
    }

    func test_invalid_instructions_format() {
        
        var invalidInstruction = "44 (2,3) (1,2)"
        var isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4 (2,,3) (1,2)"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4 (2,3) (1,2"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4 (2,3) (1,2))"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4 (2,3)    (1,2)"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4 (2,3) (1,2)  "
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "(2,3) (1,2)"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "4x4 (2,-3) (1,2)"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "-4x4 (2,3) (1,2)"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
        
        invalidInstruction = "+4x4 (2,3) (1,2)"
        isValidInstruction = validator.isValid(instruction: invalidInstruction, regex: regex)
        XCTAssertFalse(isValidInstruction)
    }

    func test_valid_instructions_format() {
        var validInstruction = "4x4 (1,3) (1,2)"
        var isValidInstruction = validator.isValid(instruction: validInstruction, regex: regex)
        XCTAssertTrue(isValidInstruction)
        
        validInstruction = "4x4 (2,3)"
        isValidInstruction = validator.isValid(instruction: validInstruction, regex: regex)
        XCTAssertTrue(isValidInstruction)
        
        validInstruction = "4x4 (2,3) (1,2) (2,3) (0,2) (2,3) (1,2)"
        isValidInstruction = validator.isValid(instruction: validInstruction, regex: regex)
        XCTAssertTrue(isValidInstruction)
    }

}
